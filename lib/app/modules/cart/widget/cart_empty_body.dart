import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/custom_button.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';

import '../../landing_screen/controller/landing_controller.dart'; // 👈 import the LandingController

class CartEmptyBody extends StatelessWidget {
  const CartEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final landingController = Get.find<LandingController>();

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
            const Row(),
            Image.asset(
              Assets.imagesCart,
              width: 180,
            ),
            const SizedBox(height: 20),
            Text(
              AppKeys.noProducts.tr,
              style: AppFonts.heading2,
            ),
            const SizedBox(height: 20),
            Text(
              AppKeys.goFindProducts.tr,
              style: AppFonts.bodyText.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.greyWithShade.withOpacity(.5),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Browse Product'.tr,
              onPressed: () {
                // 👇 Change tab index to Home
                landingController.setIndex(0);
                Get.back(); // close CartEmptyBody if it's in navigation stack
              },
            ),
          ],
        ),
      ),
    );
  }
}
