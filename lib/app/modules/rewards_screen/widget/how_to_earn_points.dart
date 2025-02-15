import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';


class HowToEarnPoints extends StatelessWidget {
  const HowToEarnPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      title: Text(
        AppKeys.howToEarnPoints.tr,
        style: AppFonts.heading3.copyWith(fontSize: 14),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {
        showCustomBottomSheet(context, buildBottomSheetEarningSteps(context));
      },
    );
  }

  Widget buildBottomSheetEarningSteps(context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppKeys.howToEarnPoints.tr,
              style: AppFonts.bodyText.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.grey.withOpacity(.1),
                child: Icon(
                  Icons.close,
                  color: AppColors.red,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 4,
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                "Points are the currency of the rewards program. In terms of how to obtain them, ",
                style: AppFonts.bodyText.copyWith(
                  color: AppColors.grey,
                  fontSize: 12,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
