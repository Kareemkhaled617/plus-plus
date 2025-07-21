import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/widgets/app_bar_back_button.dart';



class RewardsHeaderSection extends StatelessWidget {
  const RewardsHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return      Row(
      children: [
        AppBarBackButton(),
        SizedBox(width: 8),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                text: AppKeys.welcomeToYourRewards.tr,
                style: AppFonts.heading3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: " El lewaa ",
                    style: AppFonts.heading3.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
