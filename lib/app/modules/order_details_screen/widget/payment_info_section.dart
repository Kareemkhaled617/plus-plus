import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/utils/common_widgets.dart';
import '../../../domain/entities/order_entity.dart';

class PaymentInfoSection extends StatelessWidget {
  const PaymentInfoSection({super.key, required this.orderEntity});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payment Info Title
        Text(
          AppKeys.paymentInfo.tr,
          style: AppFonts.heading2,
        ),
        SizedBox(height: 10),

        // Discount Card
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppColors.greyWithShade.withOpacity(.2))),
          child: ListTile(
            leading: Image.asset(Assets.iconsOffers, width: 30),
            title: Text(
              "${orderEntity.discountPrice} ${AppKeys.discountApplied.tr}",
              style: AppFonts.heading3.copyWith(fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 10),

        // Payment Method Card
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppColors.greyWithShade.withOpacity(.2))),
          child: ListTile(
            leading: Image.asset(Assets.iconsVisa, width: 40), // Visa Icon
            title: Text(
              CommonWidgets.formatPaymentMethod(orderEntity.paymentMethod),
              style: AppFonts.bodyText
                  .copyWith(fontSize: 16, color: AppColors.primary),
            ),
          ),
        ),
        SizedBox(height: 20),

        // Price Details
        buildPriceRow(AppKeys.subtotal.tr,
            "${orderEntity.totalPrice} ${AppKeys.le}", AppColors.deepRed),
        buildPriceRow(AppKeys.delivery.tr,
            "${orderEntity.orderChargePrice} ${AppKeys.le}", AppColors.deepRed),
        buildPriceRow(
            AppKeys.total.tr,
            "${orderEntity.totalPrice + orderEntity.orderChargePrice} ${AppKeys.le}",
            AppColors.deepRed),

        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget buildPriceRow(String label, String amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.heading2,
          ),
          Text(
            amount,
            style: AppFonts.bodyText.copyWith(fontSize: 16, color: color),
          ),
        ],
      ),
    );
  }
}
