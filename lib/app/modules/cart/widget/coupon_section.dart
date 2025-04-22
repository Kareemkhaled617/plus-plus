import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/custom_bottom_sheet.dart';
import 'package:plus/app/core/widgets/custom_button.dart';
import 'package:plus/app/core/widgets/custom_text_form_field.dart';
import 'package:plus/generated/assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../controller/cart_controller.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.babyBlue.withOpacity(.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                Assets.iconsOffers,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Text(
                AppKeys.addCoupon.tr,
                style: AppFonts.heading3,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              // showCustomBottomSheet(context, buildCouponDialogContent(context));
              showCouponDialog(context, cartController);
            },
            child: Text(
              AppKeys.add.tr,
              style: AppFonts.heading3.copyWith(
                fontSize: 12,
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildCouponDialogContent(context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppKeys.addCoupon.tr,
              style: AppFonts.heading3,
            ),
            Spacer(),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        CustomTextFormField(
          hintText: AppKeys.addTheCouponHere.tr,
          fillColor: AppColors.grey.withOpacity(.1),
        ),
        SizedBox(
          height: 20,
        ),
        CustomButton(
          text: AppKeys.apply,
          onPressed: () {},
        )
      ],
    );
  }

  void showCouponDialog(BuildContext context, CartController controller) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.white,
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    AppKeys.addCoupon.tr,
                    style: AppFonts.heading3.copyWith(fontSize: 16),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hintText: AppKeys.addTheCouponHere.tr,
                fillColor: AppColors.grey.withOpacity(.1),
                controller: controller.copounController,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: AppKeys.apply.tr,
                onPressed: () {
                  controller.addToCartApi();
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
