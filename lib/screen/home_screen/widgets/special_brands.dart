import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/utils/app_colors.dart';

import '../../../utils/app_fonts.dart';
import '../../products_screen/products_screen.dart';

class SpecialBrand extends StatelessWidget {
  final List<Map<String, String>> categories;

  const SpecialBrand({
    required this.categories,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              Get.to(ProductsScreen(
                gradientColors: [
                  AppColors.white,
                  AppColors.white,
                ], title: 'Vaseline',
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(category['imageUrl']!, fit: BoxFit.contain),
              ),
            ),
          );
        },
      ),
    );
  }
}
