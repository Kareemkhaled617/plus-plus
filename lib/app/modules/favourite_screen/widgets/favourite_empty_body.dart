import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';


class FavouriteEmptyBody extends StatelessWidget {
  const FavouriteEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Image.asset(Assets.imagesEmptyFavourite, width: 180),
        SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppKeys.noFavouriteProducts.tr,
              style: AppFonts.bodyText,
            ),
          ],
        ),
      ],
    );
  }
}
