import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:plus/app/core/theme/app_fonts.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/core/widgets/custom_button.dart';

class AllPrescriptionScreen extends StatelessWidget {
  const AllPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: AppBarBackButton(),
        title: Text(
          "All Prescription".tr,
          style: AppFonts.heading1.copyWith(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PrescriptionCard(),
          ],
        ),
      ),
    );
  }
}

class PrescriptionCard extends StatelessWidget {
  const PrescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Section
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  "27",
                  style: AppFonts.heading3
                      .copyWith(color: AppColors.white, fontSize: 14),
                ),
                Text(
                  "FEB",
                  style: AppFonts.heading3
                      .copyWith(color: AppColors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),

          // Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Records added by you".tr,
                  style: AppFonts.heading3
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "1 Prescription".tr,
                  style: AppFonts.bodyText
                      .copyWith(fontSize: 12, color: AppColors.grey),
                ),
              ],
            ),
          ),

          // Status + View Button
          Column(
            children: [
              // Status Label
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Pending...".tr,
                  style: AppFonts.bodyText
                      .copyWith(fontSize: 12, color: AppColors.red),
                ),
              ),
              SizedBox(height: 8),

              // View Button
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding:  EdgeInsets.symmetric(horizontal: 8),
                     backgroundColor: AppColors.primary,
                    minimumSize: Size(80, 30),
                    shape: RoundedRectangleBorder(


                      borderRadius: BorderRadius.circular(8),
                    )),
                  child: Text(
                    "View".tr,
                    style: AppFonts.bodyText.copyWith(color: AppColors.white,fontSize: 12),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
