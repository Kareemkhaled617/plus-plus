import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/storage/secure_storage_helper.dart';
import '../../../domain/usecases/create_order_usecase.dart';
import '../widget/show_order_Success_sheet.dart';

class CheckoutController extends GetxController {
  CheckoutController(this.createOrderUseCase);

  var selectedIndex = 0.obs;
  var showCardDetails = false.obs;
  TextEditingController point = TextEditingController(text: '0');
  final CreateOrderUseCase createOrderUseCase;
  var isLoading = false.obs;

  final List<String> options = [
    "Cash on delivery",
    "Visa on delivery",
    "Pay with your card /credit card"
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
    required int userAddressId,
    required String paymentMethod,
    required int userPoints,
  }) async {
    isLoading.value = true;

    final result = await createOrderUseCase(
      userAddressId: userAddressId,
      paymentMethod: paymentMethod,
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
