import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/widgets/custom_button.dart';

class LogoutBottomSheetContent extends StatelessWidget {
  const LogoutBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppKeys.logout.tr,
          style: AppFonts.heading3
              .copyWith(fontSize: 21)
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          AppKeys.logoutDescription.tr,
          style: AppFonts.bodyText.copyWith(
            fontSize: 14,
            color: AppColors.grey,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {},
                text: AppKeys.logout.tr,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.red),
                ),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    AppKeys.cancel.tr,
                    style: AppFonts.bodyText
                        .copyWith(color: AppColors.red),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
