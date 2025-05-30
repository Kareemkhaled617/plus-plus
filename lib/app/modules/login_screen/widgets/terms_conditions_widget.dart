import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import '../../privacy_policy/privacy_policy_screen.dart';
import '../controller/auth_controller.dart';
import '../../../core/utils/app_keys.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          final authController = Get.find<AuthController>();
          return Checkbox(
            value: authController.isChecked.value,
            onChanged: (bool? value) {
              authController.toggleTermsAgreement(value ?? false);
            },
          );
        }),
        Text(AppKeys.iAgreeTo.tr),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () {
            showPrivacyPolicyBottomSheet(context);
          },
          child: Text(
            AppKeys.terms.tr,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(AppKeys.and.tr),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () {
            showPrivacyPolicyBottomSheet(context);
          },
          child: Text(
            AppKeys.conditions.tr,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
