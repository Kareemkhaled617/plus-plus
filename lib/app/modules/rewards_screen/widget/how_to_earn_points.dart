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
        style: AppFonts.heading3.copyWith(fontSize: 14,fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 20),
      onTap: () {
        showCustomBottomSheet(context, buildBottomSheetEarningSteps(context));
      },
    );
  }

  Widget buildBottomSheetEarningSteps(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Text(
                AppKeys.howToEarnPoints.tr,
                style: AppFonts.heading2,
              ),
              Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.grey.withOpacity(0.1),
                  child: Icon(Icons.close, color: AppColors.red, size: 20),
                ),
              )
            ],
          ),
          SizedBox(height: 20),

          // Step 1: Introduction
          _buildBulletText(
            "intro".tr,
          ),

          // Step 2: Online
          _buildBulletText(
            "online".tr,
            highlight: "The first is online",
          ),

          // Step 3: Offline
          _buildBulletText(
            "offline".tr,
            highlight: "The second is offline",
          ),

          // Step 4: Purchase policy
          _buildBulletText(
            "policy".tr ,
          ),
        ],
      ),
    );
  }

// Helper to build each bullet point with optional bold prefix
  Widget _buildBulletText(String text, {String? highlight}) {
    List<TextSpan> spans = [];

    if (highlight != null && text.startsWith(highlight)) {
      spans.add(TextSpan(
        text: highlight,
        style: AppFonts.bodyText.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.grey,
        ),
      ));
      spans.add(TextSpan(
        text: text.substring(highlight.length),
        style: AppFonts.bodyText.copyWith(
          fontSize: 14,
          color: AppColors.grey,
        ),
      ));
    } else {
      spans.add(TextSpan(
        text: text,
        style: AppFonts.bodyText.copyWith(
          fontSize: 14,
          color: AppColors.grey,
        ),
      ));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: CircleAvatar(
              radius: 4,
              backgroundColor: AppColors.primary,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(children: spans),
            ),
          ),
        ],
      ),
    );
  }

}
