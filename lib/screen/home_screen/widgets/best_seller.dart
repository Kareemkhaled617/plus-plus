import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/components/product_item.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';
import 'package:plus/utils/common_widgets.dart';

import '../../../generated/assets.dart';
import '../../product_details_screen/product_details_screen.dart';
import '../../products_screen/products_screen.dart';

class BestSeller extends StatelessWidget {
  const BestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFB0C5FF).withOpacity(.3),
            Color(0xFF4A00E0).withOpacity(.4),
          ],
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Seller'.tr,
                style: AppFonts.heading2
                    .copyWith(color: AppColors.primary, fontSize: 18),
              ),
              InkWell(
                onTap: () {
                  Get.to(ProductsScreen(
                    gradientColors: [
                      Color(0xFFB0C5FF).withOpacity(.3),
                      Color(0xFF4A00E0).withOpacity(.4),
                    ],
                    title: 'Best seller',
                  ));
                },
                child: Text(
                  'View all'.tr,
                  style: AppFonts.heading2.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  7,
                  (index) => InkWell(
                    onTap: () {
                      Get.to(
                            () => ProductDetailsScreen(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 500),
                      );

                    },
                    child: ProductCard(
                      imageUrl: Assets.tempDsd,
                      title: "Evy Baby",
                      stockInfo: "68 in stock",
                      price: "45 L.E",
                      onAddToCart: () {},
                      onFavorite: () {},
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
