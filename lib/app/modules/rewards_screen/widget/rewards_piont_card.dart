import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/account_screen/controller/account_controller.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';

class RewardsPointsCard extends StatelessWidget {
  const RewardsPointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountController>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesPointsCardBg),
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppKeys.yourPoints.tr,
            style:
                AppFonts.heading3.copyWith(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.iconsCoin, width: 24, height: 24),
              SizedBox(width: 4),
              Text(
                controller.points.value.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${AppKeys.pointsExpiryDate.tr} ${controller.pointsList.last.date}",
                  style: AppFonts.bodyText.copyWith(
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
