import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../domain/entities/prescription_entity.dart';

class PrescriptionCard extends StatelessWidget {
  final PrescriptionEntity prescription;

  const PrescriptionCard({super.key, required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat.d()
                          .format(DateTime.parse(prescription.createdAt)),
                      style: AppFonts.heading2
                          .copyWith(color: AppColors.white, fontSize: 16),
                    ),
                    Text(
                      DateFormat.MMM()
                          .format(DateTime.parse(prescription.createdAt))
                          .toUpperCase(),
                      style: AppFonts.heading2
                          .copyWith(color: AppColors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prescription.orderProductNames, // Dynamically show name
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.heading3
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      AppKeys.prescription.tr,
                      style: AppFonts.bodyText
                          .copyWith(fontSize: 12, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),

              /// **Status Section**
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      prescription.status,
                      style: AppFonts.bodyText.copyWith(
                          fontSize: 14,
                          color: AppColors.red,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ],
          ),

          /// **View Button**
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(80, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  AppKeys.view.tr,
                  style: AppFonts.bodyText.copyWith(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
