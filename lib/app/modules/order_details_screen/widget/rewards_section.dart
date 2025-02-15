import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';


class RewardsSection extends StatelessWidget {
  const RewardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.babyBlue.withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppKeys.youEarned.tr} 500 ${AppKeys.points.tr}!",
                  style: AppFonts.heading3.copyWith(fontSize: 14),
                ),
                SizedBox(height: 5),
                Text(
                  AppKeys.redeem.tr,
                  style: AppFonts.bodyText.copyWith(fontSize: 10),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {

                  },
                  child: Text(
                    AppKeys.viewMyRewards.tr,
                    style: AppFonts.bodyText.copyWith(color: AppColors.primary, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Image.asset(Assets.imagesEarnedPoint)),
        ],
      ),
    );
  }
}
