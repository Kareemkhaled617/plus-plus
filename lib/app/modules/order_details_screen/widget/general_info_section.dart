import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';


class GeneralInfoSection extends StatelessWidget {
  const GeneralInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppKeys.generalInfo.tr, style: AppFonts.heading3),
        SizedBox(height: 16,),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.greyWithShade.withOpacity(.2))
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppKeys.orderId.tr,
                        style: AppFonts.heading3.copyWith(fontSize: 13)),
                    Text("247-96024",
                        style: AppFonts.heading3.copyWith(
                            fontSize: 13, color: AppColors.primary)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppKeys.orderDate.tr,
                      style: AppFonts.heading3.copyWith(fontSize: 13),
                    ),
                    Text(
                      "1/2/2025 , 12:05",
                      style: AppFonts.heading3
                          .copyWith(fontSize: 13, color: AppColors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
