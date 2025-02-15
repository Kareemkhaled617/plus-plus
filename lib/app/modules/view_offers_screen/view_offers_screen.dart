import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/view_offers_screen/widget/brands_dropdown.dart';
import 'package:plus/generated/assets.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../home_screen/widgets/products_grid.dart';

class ViewOffersScreen extends StatelessWidget {
  const ViewOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.babyBlue.withOpacity(.5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(Assets.tempLargeBanner),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            color: AppColors.deepRed,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              "Through two hours, Dont miss the chance !".tr,
                              style: AppFonts.bodyText.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Image.asset(Assets.iconsOffersPercent, height: 20),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              "Buy one product and you will get the second one free"
                                  .tr,
                              style: AppFonts.bodyText.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BrandsDropdown(),
                ),
                ProductsGrid()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
