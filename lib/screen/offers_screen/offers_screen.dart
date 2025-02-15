import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/components/product_item.dart';
import 'package:plus/screen/offers_screen/widget/widget/offer_image_widget.dart';
import 'package:plus/screen/offers_screen/widget/widget/offers_banner_section.dart';
import 'package:plus/screen/offers_screen/widget/widget/products_in_offers_section.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_keys.dart';
import '../../generated/assets.dart';
import '../../utils/app_fonts.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      text: "${AppKeys.exclusiveOffers.tr} ",
                      style: AppFonts.heading3.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "PLUS PLUS 🔥",
                          style: AppFonts.heading3.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                OffersBannerSection(),
                Divider(
                  color: AppColors.greyWithShade.withOpacity(.3),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${AppKeys.discount.tr} 💯",
                      style: AppFonts.bodyText.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      AppKeys.viewAll.tr,
                      style: AppFonts.bodyText.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                          fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ProductsInOffersSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
