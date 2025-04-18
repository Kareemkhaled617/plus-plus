import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../account_screen/controller/account_controller.dart';
import '../controller/auth_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_keys.dart';

class SubmitButtonWidget extends StatelessWidget {
  final AuthController authController;
  final TextEditingController phoneController;

  const SubmitButtonWidget({
    super.key,
    required this.authController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Obx(() => SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: (authController.isButtonEnabled.value &&
                      authController.isLoading.value == false)
                  ? ()  {
                      authController.login(phoneController.text, true);
                    }
                  : null,
              child: authController.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      AppKeys.sendCode.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          )),
    );
  }
}
