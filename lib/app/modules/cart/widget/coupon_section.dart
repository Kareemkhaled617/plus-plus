import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/custom_button.dart';
import 'package:plus/app/core/widgets/custom_text_form_field.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../controller/cart_controller.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Promo Code'.tr,
          style: AppFonts.heading2,
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey)),
          child: CustomTextFormField(
            hintText: AppKeys.addTheCouponHere.tr,
            fillColor: AppColors.grey.withOpacity(.1),
            controller: cartController.copounController,
            prefixIcon: Icon(
              Icons.local_offer_rounded,
              color: AppColors.red,
            ),
            suffixIcon: SizedBox(
              width: 100,
              height: 60,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
                child: CustomButton(
                  text: AppKeys.apply.tr,
                  onPressed: () {
                    cartController.addToCartApi();
                    Get.back();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
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
                suffixIcon: SizedBox(
                  width: 80,
                  child: CustomButton(
                    text: AppKeys.apply.tr,
                    onPressed: () {
                      controller.addToCartApi();
                      Get.back();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
