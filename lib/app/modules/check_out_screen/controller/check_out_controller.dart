import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/storage/secure_storage_helper.dart';
import '../../../domain/entities/OrderPriceEntity.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/entities/cart_total_entity.dart';
import '../../../domain/usecases/CalculateOrderPriceUseCase.dart';
import '../../../domain/usecases/create_order_usecase.dart';
import '../../cart/controller/cart_controller.dart';
import '../widget/show_order_Success_sheet.dart';

class CheckoutController extends GetxController {
  CheckoutController(this.createOrderUseCase, this.useCase);

  final CalculateOrderPriceUseCase useCase;

  var selectedIndex = 0.obs;
  var showCardDetails = false.obs;
  TextEditingController point = TextEditingController(text: '0');
  final CreateOrderUseCase createOrderUseCase;
  var isLoading = false.obs;
  var isLoadingCalculate = false.obs;
  var priceInfo = Rxn<OrderPriceEntity>();
  CartController cartController = Get.find<CartController>();

  Future<void> calculate(String userPoints) async {
    isLoadingCalculate.value = true;
    final result = await useCase(
        userPoints,
        cartController.selectedAddress.value!.lat,
        cartController.selectedAddress.value!.lng);
    result.fold(
      (failure) => Get.snackbar("Error".tr, failure.message),
      (data) {
        priceInfo.value = data;
        cartController.cartTotal.value = CartTotalEntity(
            totalPrice: data.totalPrice,
            totalDiscount: data.discountPrice,
            couponDiscount: data.discountPrice,
            chargePrice: data.chargePrice,
            riderTip: data.riderTip,
            totalPriceAfterCharge: data.finalPrice);
      },
    );
    isLoadingCalculate.value = false;
  }

  final List<String> options = [
    "Cash on delivery",
    "Visa on delivery",
    "Pay with your card /credit card"
  ];
  final List<String> images = [
    "assets/icons/cash.png",
    "assets/icons/visas.png",
    "assets/icons/credit.png"
  ];

  String mapPaymentOptionToApiValue(String option) {
    switch (option.toLowerCase()) {
      case "cash on delivery":
        return "pay_on_delivery";
      case "visa on delivery":
        return "visa_on_delivery";
      case "pay with your card /credit card":
        return "credit_card";
      default:
        return "";
    }
  }

  Future<void> createOrder({
    required AddressEntity userAddress,
    required String paymentMethod,
    required String couponCode,
    required String riderTip,
    required int userPoints,
  }) async {
    isLoading.value = true;

    final result = await createOrderUseCase(
      userAddress: userAddress,
      paymentMethod: paymentMethod,
      riderTip: riderTip,
      couponCode: couponCode,
      userPoints: userPoints,
    );

    isLoading.value = false;

    result.fold(
      (failure) => Get.snackbar("Error".tr, failure.message),
      (order) async {
        Get.snackbar("Success".tr.tr, order.message);
        showOrderSuccessSheet(Get.context!);
        await SecureStorageHelper().deleteData('cart_data');
      },
    );
  }

  void selectOption(int index) {
    selectedIndex.value = index;
    showCardDetails.value = index == 2;
  }
}
