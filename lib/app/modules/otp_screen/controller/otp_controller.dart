import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import '../../../core/errors/failure.dart';
import '../../../routes/app_routes.dart';
import '../../../core/storage/secure_storage_helper.dart';
import '../../cart/controller/cart_controller.dart';
import '../../favourite_screen/controller/favorite_controller.dart';
import '../../login_screen/controller/auth_controller.dart';

class OTPController extends GetxController {
  final VerifyOtpUseCase verifyOtpUseCase;

  OTPController(this.verifyOtpUseCase);

  final authController = Get.find<AuthController>();

  final otpTextController = TextEditingController();
  var phoneNumber = ''.obs;
  var isButtonEnabled = false.obs;
  var isLoading = false.obs;
  var countdown = 60.obs;
  Timer? _timer;

  @override
  void onInit() {
    phoneNumber.value = Get.arguments["phone"] ?? "";
    startCountdown();
    super.onInit();
  }

  void startCountdown() {
    _timer?.cancel(); // Cancel any existing timer
    countdown.value = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void validateOTP(String otp) {
    isButtonEnabled.value = otp.length == 4;
  }

  // Future<void> verifyOtp() async {
  //   if (otpTextController.text.isEmpty || otpTextController.text.length < 4) {
  //     Get.snackbar("Error".tr, "Invalid OTP Code!".tr);
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   final result =
  //   await verifyOtpUseCase(phoneNumber.value, otpTextController.text);
  //
  //   result.fold(
  //         (Failure failure) {
  //       Get.snackbar("Error".tr, failure.message);
  //     },
  //         (String token) async {
  //       await SecureStorageHelper().saveData("auth_token", token);
  //       Get.snackbar("Success".tr, "OTP verified successfully!".tr);
  //       Get.offAllNamed(AppRoutes.landingScreen);
  //     },
  //   );
  //
  //   isLoading.value = false;
  // }
  Future<void> verifyOtp() async {
    if (otpTextController.text.isEmpty || otpTextController.text.length < 4) {
      Get.snackbar("Error".tr, "Invalid OTP Code!".tr);
      return;
    }

    isLoading.value = true;

    final result =
        await verifyOtpUseCase(phoneNumber.value, otpTextController.text);

    result.fold(
      (Failure failure) {
        Get.snackbar("Error".tr, failure.message);
      },
      (String token) async {
        await SecureStorageHelper().saveData("auth_token", token);
        Get.snackbar("Success".tr, "OTP verified successfully!".tr);
        // ✅ جلب بيانات السلة بعد التحقق من OTP
        final favController = Get.find<FavoriteController>();
        favController.fetchFavourites();
        final cartController = Get.find<CartController>();
        await cartController.fetchCart();


        Get.offAllNamed(AppRoutes.landingScreen);
      },
    );

    isLoading.value = false;
  }

  void resendCode() {
    Get.snackbar("Info".tr, "Resending OTP...".tr);
    authController.login(phoneNumber.value, false);
    startCountdown();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
