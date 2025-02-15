import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.babyBlue.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.percent, color: Colors.orange),
              const SizedBox(width: 8),
               Text(
                AppKeys.addCoupon.tr,
                style: AppFonts.heading3,
              ),
            ],
          ),
          Text(
            AppKeys.add.tr,
            style: AppFonts.heading3.copyWith(
              fontSize: 12,
              color: AppColors.red
            ),
          ),
        ],
      ),
    );
  }
}
