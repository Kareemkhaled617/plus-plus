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
      children: [
        SizedBox(height: 60,),
        Image.asset(
          Assets.imagesEmptyHistory,
          width: 170,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          AppKeys.noOrdersPlaced.tr,
          style: AppFonts.bodyText
              .copyWith(fontSize: 16, color: AppColors.black),
        ),
        Row(),
        Text(
         AppKeys.placeYourFirstOrder.tr,
          style: AppFonts.bodyText.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
