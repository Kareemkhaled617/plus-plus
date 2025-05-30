import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/offers_screen/widget/widget/offers_banner_section.dart';
import 'package:plus/app/modules/offers_screen/widget/widget/products_in_offers_section.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../routes/app_routes.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      text: "${AppKeys.exclusiveOffers.tr} ",
                      style: AppFonts.heading3
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                      children: [
                        TextSpan(
                          text: "PLUS PLUS   🔥",
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppKeys.discount.tr} 💯",
                            style: AppFonts.bodyText.copyWith(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.allDiscountProductsScreen);
                            },
                            child: Text(
                              AppKeys.viewAll.tr,
                              style: AppFonts.bodyText.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ProductsInOffersSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
