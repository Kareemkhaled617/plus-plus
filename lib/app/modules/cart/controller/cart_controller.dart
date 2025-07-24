import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../data/models/package_type_model.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../domain/entities/cart_total_entity.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/add_to_cart_usecase.dart';
import '../../../domain/usecases/get_cart_total_usecase.dart';
import '../../../domain/usecases/get_cart_usecase.dart';
import '../../../domain/usecases/remove_from_cart_use_case.dart';
import '../../../domain/usecases/remove_from_cart_usecase.dart';

class CartController extends GetxController {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  var cartItems = <ProductEntity>[].obs;
  var itemCounts = <int, int>{}.obs;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final GetCartUseCase getCartUseCase;
  final RemoveAllFromCartUseCase removeAllFromCartUseCase;

  final GetCartTotalUseCase getCartTotalUseCase;
  final TextEditingController copounController = TextEditingController();
  final RxString copounText = ''.obs;
  Rxn<CartEntity> updatedCart = Rxn<CartEntity>();
  Rxn<AddressEntity> selectedAddress = Rxn<AddressEntity>();
  final isLoading = true.obs;
  var cartTotal = Rxn<CartTotalEntity>();
  var isLoadingTotalCart = false.obs;

  Future<void> fetchCartTotal(String lat, String lng) async {
    isLoadingTotalCart.value = true;
    final result = await getCartTotalUseCase(lat: lat, lng: lng);
    result.fold(
      (failure) => Get.snackbar('Error'.tr, failure.message),
      (data) => cartTotal.value = data,
    );
    isLoadingTotalCart.value = false;
  }

  void selectAddress(AddressEntity address) {
    selectedAddress.value = address;
  }

  CartController(this.addToCartUseCase, this.removeFromCartUseCase,
      this.getCartUseCase,
      this.getCartTotalUseCase,
      this.removeAllFromCartUseCase);

  @override
  void onInit() {
    super.onInit();
    copounController.addListener(() {
      copounText.value = copounController.text;
    });
    loadCartFromCache();
  }



  Future<void> fetchCart() async {
    isLoading.value = true;

    final result = await getCartUseCase();
    result.fold(
          (failure) {
        isLoading.value = false;
        log("Error: ${failure.message}");
      },
          (cartList) {
        // تحويل CartRequestEntity إلى ProductModel
        final products = cartList.map((item) => ProductModel.fromCartEntity(item)).toList();

        cartItems.assignAll(products);

        for (var item in cartList) {
          itemCounts[item.product.id] = item.quantity;
        }

        saveCartToCache();
        isLoading.value = false;
      },
    );
  }


  Future<void> addToCartApi() async {
    if (cartItems.isEmpty) {
      return;
    }
    isLoading.value = true;

    // 🧠 توليد البيانات من cartItems
    final productIds = <int>[];
    final quantityIds = <int>[];
    final packageTypeIds = <int?>[];

    for (var item in cartItems) {
      productIds.add(item.id);

      final quantity = itemCounts[item.id] ?? 1;
      quantityIds.add(quantity);

      final packageTypeId = (item is ProductModel && item.isSelected)
          ? item.packageTypes.isNotEmpty
              ? item.packageTypes.first.id
              : null
          : null;
      packageTypeIds.add(packageTypeId);
    }

    final result = await addToCartUseCase(
      productIds: productIds,
      quantityIds: quantityIds,
      packageTypeIds: packageTypeIds,
      couponCode: copounController.value.text, // أو يمكن تمرير كود من الشاشة
    );

    isLoading.value = false;
    print(' isLoading.value');
    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (cartEntity) {
        // Get.snackbar("Success".tr, "The product has been added to the cart successfully.".tr);
        updatedCart.value = cartEntity;
      },
    );
  }

  RxBool isRemoving = false.obs;

  Future<void> removeItemApi(int productId) async {
    isRemoving.value = true;
    final result = await removeFromCartUseCase(productId);
    isRemoving.value = false;

    if (result.isRight()) {
      Get.snackbar('Success'.tr, 'Product removed from cart successfully'.tr);
      // Optionally refresh the cart items list
    } else {
      Get.snackbar('Error'.tr, 'Failed to remove product from cart'.tr);
    }
  }

  /// 🛒 Add product to cart (or increase count if exists)
  // void addToCart(ProductEntity product, {bool isSelect = false}) {
  //   if (itemCounts.containsKey(product.id)) {
  //     itemCounts[product.id] = (itemCounts[product.id] ?? 0) + 1;
  //   } else {
  //     // If you want to save selection state, clone the product and assign it
  //     if (product is ProductModel) {
  //       cartItems.add(product.copyWith(isSelected: isSelect));
  //     } else {
  //       cartItems.add(product);
  //     }
  //     itemCounts[product.id] = 1;
  //   }
  //   saveCartToCache();
  // }
  void addToCart(ProductEntity product, {bool isSelect = false}) {
    int currentCount = itemCounts[product.id] ?? 0;

    // ✅ Check if adding more exceeds stock
    if (currentCount >= product.stock) {
      Get.snackbar(
        "Stock Limit".tr,
        "You have reached the maximum available stock for this product.".tr,
      );
      return;
    }

    if (itemCounts.containsKey(product.id)) {
      itemCounts[product.id] = currentCount + 1;
    } else {
      if (product is ProductModel) {
        cartItems.add(product.copyWith(isSelected: isSelect));
      } else {
        cartItems.add(product);
      }
      itemCounts[product.id] = 1;
    }

    saveCartToCache();
  }

  /// ✅ Get the isSelected value of a product by ID
  bool isProductSelected(int productId) {
    final product = cartItems.firstWhereOrNull((item) => item.id == productId);
    if (product is ProductModel) {
      return product.isSelected;
    }
    return false;
  }

  /// ✅ Update isSelected value for a product by ID
  void updateProductSelection(int productId, bool isSelected) {
    final index = cartItems.indexWhere((item) => item.id == productId);
    if (index != -1) {
      final product = cartItems[index];
      if (product is ProductModel) {
        cartItems[index] = product.copyWith(isSelected: isSelected);

        saveCartToCache();
      }
    } else {
      log("Product with ID $productId not found in cart");
    }
  }

  double getSubtotal() {
    double subtotal = 0.0;
    for (var item in cartItems) {
      double discount = item.price * (item.discountValue / 100);
      double discountedPrice = item.price - discount;
      subtotal += discountedPrice * (itemCounts[item.id] ?? 1);
    }
    return subtotal;
  }

  /// ❌ Remove product (if count > 1, decrease count; else remove)
  void removeFromCart(int productId) {
    if (itemCounts.containsKey(productId)) {
      if (itemCounts[productId]! > 1) {
        itemCounts[productId] = itemCounts[productId]! - 1;
      } else {
        itemCounts.remove(productId);
        cartItems.removeWhere((item) => item.id == productId);
      }
      saveCartToCache();
    }
  }

  /// 🗑️ Remove all quantity of a product from the cart
  void removeAllProductFromCart(int productId) {
    itemCounts.remove(productId);
    cartItems.removeWhere((item) => item.id == productId);
    saveCartToCache();
  }

  /// ✅ Check if product is in cart
  bool isProductInCart(int productId) {
    return itemCounts.containsKey(productId);
  }

  /// 🔢 Get product count in cart
  int getProductCount(int productId) {
    return itemCounts[productId] ?? 0;
  }

  /// 💾 Save cart to secure storage
  Future<void> saveCartToCache() async {
    try {
      List<Map<String, dynamic>> cartData = cartItems
          .map((product) => (product as ProductModel).toJson())
          .toList();

      // ✅ Convert `int` keys to `String` before saving
      Map<String, String> stringCounts = itemCounts
          .map((key, value) => MapEntry(key.toString(), value.toString()));

      Map<String, dynamic> storedData = {
        "items": cartData,
        "counts": stringCounts,
      };

      await _secureStorage.write(
          key: 'cart_data', value: jsonEncode(storedData));
    } catch (e) {
      log("Error saving cart data: $e");
    }
  }

  /// 🔄 Load cart from secure storage (FIXED)
  Future<void> loadCartFromCache() async {
    try {
      String? storedData = await _secureStorage.read(key: 'cart_data');
      if (storedData != null) {
        Map<String, dynamic> jsonData = jsonDecode(storedData);
        print('jsonData---------------');
        log(jsonData.toString());
        cartItems.assignAll((jsonData["items"] as List)
            .map((item) => ProductModel(
                  id: item['id'] ?? 0,
                  name: item['name'] ?? '',
                  description: item['description'] ?? '',
                  benefits: (item['benefits'] as String?)?.split(" ") ?? [],
                  // Convert string to list
                  price: (item['price'] as num?)?.toDouble() ?? 0.0,
                  stock: item['stock'] ?? 0,
                  imageUrl: item['image'] ?? '',
                  bodyImages: (item['body-images'] as List<dynamic>?)
                          ?.map((img) => img.toString())
                          .toList() ??
                      [],
                  brandId: item['brand']?['id'] ?? 0,
                  brandName: item['brand']?['name'] ?? '',
                  brandImage: item['brand']?['image'] ?? '',
                  categories: (item['categories'] as List<dynamic>?)
                          ?.map((cat) => CategoryModel.fromJson(cat))
                          .toList() ??
                      [],
                  packageTypes: (item['package_types'] as List<dynamic>?)
                          ?.map((package) => PackageTypeModel.fromJson(package))
                          .toList() ??
                      [],
                  discountType: item['discount_type'] ?? '',
                  discountValue: item['discount']?['value'] != null
                      ? (item['discount']['value'] as num?)?.toDouble() ?? 0.0
                      : 0.0,
                  discountEndDate: item['discount']?['end_date'],
                  discountId: item['discount']?['discount_id'] ?? 0,
                  offerType: item['offer']?['offer_type'] ?? '',
                  offerDiscountPercentage:
                      item['offer']?['discount_percentage'] != null
                          ? double.tryParse(item['offer']['discount_percentage']
                                  .toString()) ??
                              0.0
                          : 0.0,
                  offerId: item['offer']?['offer_id'] ?? 0,
                  isSelected: item['is_selected'] ?? false,
                ))
            .toList());

        // ✅ Convert stored JSON `counts` keys from String → int
        Map<String, dynamic> countsData = jsonData["counts"];
        Map<int, int> convertedCounts = {};
        countsData.forEach((key, value) {
          int? parsedKey = int.tryParse(key); // Ensure conversion works
          int? parsedValue = int.tryParse(value.toString());
          if (parsedKey != null && parsedValue != null) {
            convertedCounts[parsedKey] = parsedValue;
          }
        });

        itemCounts.assignAll(convertedCounts); // Assign fixed data
      }
    } catch (e) {
      log("Error decoding cart data: $e");
    }
  }

  /// 🗑️ Clear entire cart
  // Future<void> clearCart() async {
  //   cartItems.clear();
  //   itemCounts.clear();
  //   await _secureStorage.delete(key: 'cart_data');
  // }
  void clearCart() async {
    final result = await removeAllFromCartUseCase();

    result.fold(
      (failure) {
        Get.snackbar(
          'Error'.tr,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
      (success) async {
        if (success) {
          cartItems.clear();
          itemCounts.clear();
          await _secureStorage.delete(key: 'cart_data');

          Get.snackbar(
            'Success'.tr,
            'Cart cleared successfully'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      },
    );
  }
}
