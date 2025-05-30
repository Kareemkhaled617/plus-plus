import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(2),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
