import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/home_screen/widgets/product_item.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';

import '../../../generated/assets.dart';

class BestSeller extends StatelessWidget {
  const BestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white, // Light Blue
            Color(0xFF4A00E0).withOpacity(.4), // Deep Blue
          ],
        ),
        borderRadius: BorderRadius.circular(20), // Optional rounded corners
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Seller'.tr,
                style: AppFonts.heading2.copyWith(color: AppColors.primary),
              ),
              InkWell(
                onTap: () {},
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
                  (index) => ProductCard(
                    imageUrl: Assets.tempDsd,
                    title: "Evy Baby",
                    stockInfo: "68 in stock",
                    price: "45 L.E",
                    onAddToCart: () {},
                    onFavorite: () {},
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
