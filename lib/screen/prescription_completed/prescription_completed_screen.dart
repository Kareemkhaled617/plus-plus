import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/utils/app_colors.dart';
import '../../generated/assets.dart';
import '../../utils/app_fonts.dart';
import '../../utils/app_keys.dart';

class PrescriptionCompletedScreen extends StatelessWidget {
  const PrescriptionCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          children: [
            Image.asset(
              Assets.imagesPrescriptionDone,
              width: 200,
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "${AppKeys.thankYou.tr}, Khaled",
              style: AppFonts.heading3.copyWith(
                color: AppColors.primary,
                fontSize: 22
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              AppKeys.yourRequestHasBeenReceived.tr,
              style: AppFonts.bodyText.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 120,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 15),
                minimumSize: Size(180, 43),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                AppKeys.done.tr,
                style: AppFonts.heading3.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
