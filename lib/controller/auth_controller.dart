import 'package:get/get.dart';

class AuthController extends GetxController {
  var isButtonEnabled = false.obs;

  void validatePhoneNumber(String phone) {
    isButtonEnabled.value = phone.length >= 10;
  }

  void sendCode() {

  }

  void verifyOtp(String otp) {
    // Logic to verify OTP
  }
}
