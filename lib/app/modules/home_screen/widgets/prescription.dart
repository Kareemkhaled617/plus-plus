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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.file_open,color: AppColors.primary,size: 30,),
              SizedBox(width: 8,),
              Flexible(
                child: Text(
                  AppKeys.youCanOrderPrescription.tr,
                  style: AppFonts.bodyText.copyWith(
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: AppColors.black,
                      fontSize: getResponsiveFontSize(14)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.prescription);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primary,
                  ),
                  child: Text(
                    AppKeys.here.tr,
                    textAlign: TextAlign.start,
                    style: AppFonts.heading1.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: getResponsiveFontSize(15)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
