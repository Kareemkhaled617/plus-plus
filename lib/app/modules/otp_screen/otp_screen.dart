import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_keys.dart';
import '../../core/utils/common_widgets.dart';
import 'controller/otp_controller.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OTPController controller = Get.find<OTPController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              AppKeys.verifyOtp.tr,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              AppKeys.otpCodeSent.tr,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
                  controller.phoneNumber.value,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            const SizedBox(height: 30),

            /// **OTP Input**
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
              child: PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                controller: controller.otpTextController,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                  inactiveColor: Colors.grey,
                  selectedColor: Colors.blue,
                ),
                animationDuration: const Duration(milliseconds: 300),
                onChanged: (value) {
                  controller.validateOTP(value);
                },
                appContext: context,
              ),
            ),
            const SizedBox(height: 30),

            /// **Submit Button**
            Center(
              child: Obx(() => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isButtonEnabled.value
                            ? AppColors.primary
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: controller.isButtonEnabled.value &&
                              controller.isLoading.value == false
                          ? () => controller.verifyOtp()
                          : null,
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              AppKeys.submit.tr,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                    ),
                  )),
            ),

            const SizedBox(height: 20),

            /// **Countdown Timer**
            Center(
              child: Obx(() => Text(
                    "00:${controller.countdown.value.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  )),
            ),
            const SizedBox(height: 10),

            /// **Resend Code**
            Center(
              child: GestureDetector(
                onTap: controller.countdown.value == 0
                    ? () => controller.resendCode()
                    : null,
                child: Obx(() => Text(
                      AppKeys.resendCode.tr,
                      style: TextStyle(
                        color: controller.countdown.value == 0
                            ? Colors.blueAccent
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
