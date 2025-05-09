import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../core/errors/failure.dart';
import '../../../core/storage/secure_storage_helper.dart';
import '../../../routes/app_routes.dart';
import '../../account_screen/controller/account_controller.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController(this.loginUseCase);

  /// **Observables for UI State**
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var phoneCode = ''.obs;
  var isButtonEnabled = false.obs;
  var phoneNumber = ''.obs;
  var isChecked = false.obs; // ✅ Added for Terms & Conditions Checkbox
  final TextEditingController phoneController = TextEditingController();

  /// **Handles Phone Number Validation**
  void validatePhoneNumber(String phone) {
    phoneNumber.value = phone;
    isButtonEnabled.value = phone.length >= 10;
  }

  /// **Handles Login Request**
  Future<void> login(String phone, bool isLogin) async {
    FocusScope.of(Get.context!).unfocus();
    print(phone);
    if (phone.isEmpty || phone.length < 10) {
      errorMessage.value = "Invalid phone number!".tr;
      Get.snackbar("Error".tr, "Please enter a valid phone number.".tr);
      return;
    }
    if (isChecked.value == false) {
      errorMessage.value = "Please accept Policy".tr;
      Get.snackbar("Error".tr, "Please accept Policy".tr);
      return;
    }

    isLoading.value = true;

    final result = await loginUseCase(phone);

    result.fold(
      (Failure failure) {
        errorMessage.value = failure.message;
        Get.snackbar("Error".tr, failure.message);
      },
      (UserEntity user) async {
        await _handleSuccessfulLogin(user, isLogin);
      },
    );

    isLoading.value = false;
  }

  /// **Handles a Successful Login**
  Future<void> _handleSuccessfulLogin(UserEntity user, bool isLogin) async {
    // final AccountController accountController = Get.find<AccountController>();

    await SecureStorageHelper().saveData('isPhone', '1');
    Get.snackbar("Success".tr, " ${user.message}");
    // await accountController.changeLanguage('en');
    if (isLogin) {
      Get.toNamed(AppRoutes.otp, arguments: {
        "phone": phoneController.text,
        'is_new_user': user.newUser,
        'change_phone': false,
      });
    }
  }

  void toggleTermsAgreement(bool value) {
    isChecked.value = value;
  }
}
