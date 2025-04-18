import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_keys.dart';

class LoginSubtitleWidget extends StatelessWidget {
  const LoginSubtitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        AppKeys.youWillReceiveCode.tr,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
