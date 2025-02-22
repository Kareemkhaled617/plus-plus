import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/rewards_screen/widget/earning_info_card.dart';
import 'package:plus/app/modules/rewards_screen/widget/how_to_earn_points.dart';
import 'package:plus/app/modules/rewards_screen/widget/rewards_header_section.dart';
import 'package:plus/app/modules/rewards_screen/widget/rewards_piont_card.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RewardsHeaderSection(),
                SizedBox(
                  height: 12,
                ),
                RewardsPointsCard(),

                SizedBox(height: 16),

                // Conversion Info
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.red, size: 20),
                    SizedBox(width: 4),
                    Text(
                      "Every 1 point = 1 EGP",
                      style: AppFonts.bodyText.copyWith(fontSize: 12),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // How to earn points
                HowToEarnPoints(),
                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppKeys.pointHistory.tr,
                      style: AppFonts.heading1,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "12 ${AppKeys.result.tr}",
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),

                // Point History List
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3, // Replace with dynamic data
                  itemBuilder: (context, index) {
                    bool isEarning = index != 1; // Example logic
                    return EarningInfoCard(isEarning: isEarning);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
