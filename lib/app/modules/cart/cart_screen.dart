import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/cart/widget/cart_empty_body.dart';
import 'package:plus/app/modules/cart/widget/cart_header.dart';
import 'package:plus/app/modules/cart/widget/cart_list_item.dart';
import 'package:plus/app/modules/cart/widget/checkout_button.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../routes/app_routes.dart';
import '../cart/controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cartController.cartItems.isNotEmpty) {
        cartController.addToCartApi();
      }
    });

    return Obx(() {
      return cartController.cartItems.isNotEmpty
          ? Scaffold(
              backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return cartController.cartItems.isNotEmpty
                    ? MyCartHeader(
                  itemCount: cartController.cartItems.length,
                  onClear: () {
                    showConfirmClearCartDialog(
                      onConfirm: () => cartController.clearCart(),
                    );
                  },
                )
                    : Container();
              }),
              // RelatedProductsList(),
              // SizedBox(height: 30),
              // Text(
              //   AppKeys.cartProducts.tr,
              //   style: AppFonts.heading1.copyWith(fontSize: 18),
              // ),
              // SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 12.0),
                child: Column(
                  children: [
                    Column(
                      children: cartController.cartItems
                          .map((product) =>
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: CartListItem(
                              product: product,
                              fromCart: true,
                            ),
                          ))
                          .toList(),
                    ),
                          // CheckoutSummary(
                          //   fromCart: true,
                          // ),
                          // SizedBox(height: 16),
                          // const SizedBox(height: 20),

                          // Stack(
                          //   children: [
                          //     Obx(
                          //             () {
                          //           return CheckoutButton(
                          //               total: cartController.isLoading.value
                          //                   ? ""
                          //                   : "${(cartController.updatedCart.value!
                          //                   .cartPriceData.totalPrice +
                          //                   cartController.updatedCart.value!
                          //                       .cartPriceData.totalDiscount +
                          //                   cartController.updatedCart.value!
                          //                       .cartPriceData.couponDiscount)} EGP",
                          //               onPressed: cartController
                          //               .isLoadingTotalCart.value
                          //               ? ()
                          //           {}: () async {
                          //           await cartController.fetchCartTotal(
                          //           cartController
                          //               .selectedAddress.value!.lat,
                          //           cartController
                          //               .selectedAddress.value!.lng);
                          //           Get.toNamed(AppRoutes.checkOutScreen);
                          //           },
                          //           );
                          //         }
                          //     ),
                          //     cartController.isLoadingTotalCart.value
                          //         ? AppLoader()
                          //         : Container()
                          //   ],
                          // ),
                          // Align(
                          //   alignment: Alignment.center,
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     child: CustomButton(
                    //       isEnabled:
                    //           !cartController.isLoadingTotalCart.value,
                    //       text: AppKeys.checkout.tr,
                    //       onPressed: () async {
                    //         if (cartController.selectedAddress.value !=
                    //             null) {
                    //           await cartController.fetchCartTotal(
                    //               cartController
                    //                   .selectedAddress.value!.lat,
                    //               cartController
                    //                   .selectedAddress.value!.lng);
                    //           Get.toNamed(AppRoutes.checkOutScreen);
                    //         } else {
                    //           Get.snackbar("Address Empty".tr,
                    //               "please select address".tr,
                    //               snackPosition: SnackPosition.TOP,
                    //               colorText: Colors.black);
                    //         }
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                    ),
            ],
                ),
              ),
              bottomNavigationBar: Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: CheckoutButton(
                    total: cartController.isLoading.value
                        ? ""
                        : "${(cartController.updatedCart.value!.cartPriceData.totalPrice + cartController.updatedCart.value!.cartPriceData.totalDiscount + cartController.updatedCart.value!.cartPriceData.couponDiscount)} ${'EGP'.tr}",
                    onPressed: cartController.isLoadingTotalCart.value
                        ? () {}
                        : () async {
                            await cartController.fetchCartTotal('0', '0', '0');
                            Get.toNamed(AppRoutes.checkOutScreen);
                          },
                  ),
                );
              }),
            )
          : const CartEmptyBody();
    });
  }


  Future<void> showConfirmClearCartDialog({
    required VoidCallback onConfirm,
  }) async {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: AppColors.red, size: 50),
              const SizedBox(height: 16),
              Text(
                "Clear Cart ?".tr,
                style: AppFonts.heading2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Are you sure you want to remove all items from your cart?".tr,
                style: AppFonts.bodyText.copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "Cancel".tr,
                        style: AppFonts.bodyText.copyWith(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        "Clear".tr,
                        style: AppFonts.bodyText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

}
