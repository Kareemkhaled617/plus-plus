import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/size_config.dart';

class Prescription extends StatelessWidget {
  const Prescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteSmoke),
          borderRadius: BorderRadius.circular(26)

          // image: DecorationImage(
          //     image: AssetImage(Get.locale!.languageCode == 'en'
          //         ? Assets.imagesPrescription
          //         : Assets.imagesPrescriptionAr),
          //     fit: BoxFit.fill)
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(250),
            child: Text(
              AppKeys.youCanOrderPrescription.tr,
              style: AppFonts.bodyText.copyWith(
                  color: AppColors.white, fontSize: getResponsiveFontSize(13)),
            ),
          ),
          SizedBox(
            height: 14,
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.prescription);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppKeys.here.tr,
                    textAlign: TextAlign.start,
                    style: AppFonts.heading1.copyWith(
                        color: AppColors.primary,
                        fontSize: getResponsiveFontSize(15)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.arrow_forward_rounded, color: AppColors.primary)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
