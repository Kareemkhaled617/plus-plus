import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';


class CartEmptyBody extends StatelessWidget {
  const CartEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          AppKeys.cart.tr,
          style: AppFonts.heading1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            Image.asset(
              Assets.imagesCart,
              width: 180,
            ),
            SizedBox(height: 20,),
            Text(
              AppKeys.noProducts.tr,
              style: AppFonts.heading2,
            ),
            SizedBox(height: 20,),
            Text(
              AppKeys.goFindProducts.tr,
              style: AppFonts.bodyText.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.greyWithShade.withOpacity(.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
