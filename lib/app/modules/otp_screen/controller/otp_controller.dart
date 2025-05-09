import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/usecases/verify_phone_use_case.dart';
import '../../../routes/app_routes.dart';
import '../../../core/storage/secure_storage_helper.dart';
import '../../cart/controller/cart_controller.dart';
import '../../favourite_screen/controller/favorite_controller.dart';
import '../../login_screen/controller/auth_controller.dart';

class OTPController extends GetxController {
  final VerifyOtpUseCase verifyOtpUseCase;
  final VerifyPhoneUseCase verifyPhoneUseCase;

  OTPController(this.verifyOtpUseCase, this.verifyPhoneUseCase);

  final authController = Get.find<AuthController>();

  var isLoading = false.obs;
  final otpTextController = TextEditingController();
  var phoneNumber = ''.obs;
  var isButtonEnabled = false.obs;
  var countdown = 60.obs;
  Timer? _timer;
  String token = '';

  Future getToken() async {
    return await FirebaseMessaging.instance.getToken().then((value) {
      token = value!;
      return null;
    });
  }

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
    await getToken();
    print('-=-=p=-=-=-=--=-=-=-=-=-==============-===');
    print(phoneNumber.value);
    if (otpTextController.text.isEmpty || otpTextController.text.length < 4) {
      Get.snackbar("Error".tr, "Invalid OTP Code!".tr);
      return;
    }

    isLoading.value = true;

    final result = await verifyOtpUseCase(
        phoneNumber.value.replaceFirst('+', ''), otpTextController.text, token);

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
        print(Get.arguments['is_new_user']);
        if (Get.arguments['is_new_user']) {
          Get.offAllNamed(AppRoutes.accountScreen,
              arguments: {'from_login': true});
        } else {
          Get.offAllNamed(AppRoutes.landingScreen);
        }
      },
    );

    isLoading.value = false;
  }

  Future<void> verifyPhone() async {
    if (otpTextController.text.isEmpty) {
      Get.snackbar("Error".tr, "Please enter verification code".tr);
      return;
    }

    isLoading.value = true;

    final result = await verifyPhoneUseCase(otpTextController.text);

    result.fold(
      (Failure failure) {
        Get.snackbar("Error".tr, failure.message);
      },
      (String message) {
        Get.offAllNamed(AppRoutes.landingScreen);
        Get.snackbar("Success".tr, message);
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
