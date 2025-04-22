import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/home_screen/home_screen.dart';
import 'package:plus/app/routes/app_routes.dart';
import '../../../generated/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../core/widgets/custom_button.dart';
import '../landing_screen/landing_screen.dart';

class PrescriptionCompletedScreen extends StatelessWidget {
  const PrescriptionCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesPrescriptionDone,
              width: 300,
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              AppKeys.thankYou.tr,
              style: AppFonts.heading3
                  .copyWith(color: AppColors.primary, fontSize: 22),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              AppKeys.yourRequestHasBeenReceived.tr,
              textAlign: TextAlign.center,
              style: AppFonts.bodyText.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 120,
            ),
            CustomButton(
              text: AppKeys.done.tr,
              onPressed: () {
                Get.offAllNamed(AppRoutes.landingScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
