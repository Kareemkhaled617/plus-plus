import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';
import 'package:plus/utils/app_fonts.dart';
import 'package:plus/utils/app_keys.dart';
import '../../../utils/app_colors.dart';

class PaymentInfoSection extends StatelessWidget {
  const PaymentInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payment Info Title
        Text(
          AppKeys.paymentInfo.tr,
          style: AppFonts.heading3,
        ),
        SizedBox(height: 10),

        // Discount Card
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.greyWithShade.withOpacity(.2))
          ),
          child: ListTile(
            leading: Image.asset(Assets.iconsOffers, width: 30),
            title: Text("1 ${AppKeys.discountApplied.tr}",style:  AppFonts.heading3.copyWith(fontSize: 14),),
          ),
        ),
        SizedBox(height: 10),

        // Payment Method Card
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.greyWithShade.withOpacity(.2))
          ),
          child: ListTile(
            leading: Image.asset(Assets.iconsVisa, width: 40), // Visa Icon
            title: Text(
              AppKeys.paymentMethod.tr,
              style: AppFonts.bodyText.copyWith(fontSize: 14,color: AppColors.primary),
            ),
          ),
        ),
        SizedBox(height: 20),

        // Price Details
        buildPriceRow(AppKeys.subtotal.tr, "250 ${AppKeys.le}", AppColors.deepRed),
        buildPriceRow(AppKeys.delivery.tr, "50 ${AppKeys.le}", AppColors.deepRed),
        buildPriceRow(AppKeys.total.tr, "300 ${AppKeys.le}", AppColors.deepRed),

        SizedBox(height: 20,)
      ],
    );
  }

  Widget buildPriceRow(String label, String amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.heading3.copyWith(fontSize: 14,fontWeight: FontWeight.w500),
          ),
          Text(
            amount,
            style: AppFonts.bodyText.copyWith(fontSize: 14, color: color),
          ),
        ],
      ),
    );
  }
}
