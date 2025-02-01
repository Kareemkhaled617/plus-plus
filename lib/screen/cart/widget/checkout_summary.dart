import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/cart/widget/cart_price_item.dart';
import 'package:plus/screen/cart/widget/coupon_section.dart';
import 'package:plus/screen/cart/widget/delivery_section.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../../utils/app_keys.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CartPriceItem(title: "Subtotal", price: "250 L.E"),
          CartPriceItem(title: "Delivery", price: "50 L.E"),
          CartPriceItem(title: "Total", price: "300 L.E", isTotal: true),
          const SizedBox(height: 12),
          Divider(
            thickness: 1,
            color: AppColors.greyWithShade.withOpacity(.5),
          ),
          const SizedBox(height: 12),
          CouponSection(),
          const SizedBox(height: 12),
          CartDeliverySection(),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              onPressed: () {},
              label: Icon(
                Icons.shopping_cart_outlined,
                size: 26,
                color: AppColors.white,
              ),
              icon: Text(
                AppKeys.checkout.tr,
                style: AppFonts.heading3.copyWith(
                  color: AppColors.white,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
