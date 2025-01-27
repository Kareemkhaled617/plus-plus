import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class Prescription extends StatelessWidget {
  const Prescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.imagesPrescription), fit: BoxFit.fill)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 250,
            child: Text(
              'You can order the prescription by uploading a picture or listing your needs from the pharmacy'
                  .tr,
              style: AppFonts.bodyText
                  .copyWith(color: AppColors.white, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Here'.tr,
                  textAlign: TextAlign.start,
                  style: AppFonts.heading1
                      .copyWith(color: AppColors.primary, fontSize: 18),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.arrow_forward_rounded, color: AppColors.primary)
              ],
            ),
          )
        ],
      ),
    );
  }
}
