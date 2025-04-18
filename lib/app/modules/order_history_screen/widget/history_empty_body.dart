import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';

class HistoryEmptyBody extends StatelessWidget {
  const HistoryEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.imagesEmptyHistory,

        ),
        SizedBox(
          height: 20,
        ),
        Text(
          AppKeys.noOrdersPlaced.tr,
          style:
              AppFonts.bodyText.copyWith(fontSize: 18, color: AppColors.black),
        ),
        Row(),
        Text(
          AppKeys.placeYourFirstOrder.tr,
          style: AppFonts.bodyText.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
