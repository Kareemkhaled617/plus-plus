import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/products_screen/products_screen.dart';
import 'package:plus/utils/app_colors.dart';

class BrandsListItem extends StatelessWidget {
  const BrandsListItem({
    super.key,
    required this.category,
    this.onTap,
  });

  final void Function()? onTap;
  final dynamic category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {
        Get.to(
          ProductsScreen(
            gradientColors: [
              AppColors.white,
              AppColors.white,
            ],
            title: 'Vaseline',
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: .5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            category["imageUrl"] ?? "",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
