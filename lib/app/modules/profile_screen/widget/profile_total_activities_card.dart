import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class ProfileTotalActivitiesCard extends StatelessWidget {
  const ProfileTotalActivitiesCard(
      {super.key,
      required this.title,
      required this.image,
      required this.onTap});

  final String title;
  final String image;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.whiteSmoke,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: AppFonts.heading1
                      .copyWith(color: AppColors.black, fontSize: 16),
                ),
              ],
            ),
          ),
          Get.locale!.languageCode == "en"
              ? Positioned(
                  top: -60,
                  right: -50,
                  child: Image.asset(
                    image,
                    height: 190,
                    width: 190,
                  ),
                )
              : Positioned(
                  top: -70,
                  left: -50,
                  child: Image.asset(
                    image,
                    height: 190,
                    width: 190,
                  ),
                ),
        ],
      ),
    );
  }
}
