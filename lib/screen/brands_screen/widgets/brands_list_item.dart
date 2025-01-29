import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/products_screen/products_screen.dart';

class BrandsListItem extends StatelessWidget {
  const BrandsListItem({
    super.key,
    required this.category,
  });

  final dynamic category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // To Navigate To Product Details Screen
        Get.to(ProductsScreen(gradientColors: [
          Color(0xffB0C5FF), // Light Blue
          Color(0xFF4625F2).withOpacity(.6), // Dark Purple
        ],));
      },
      child: Card(
        color: Colors.white,
        elevation: 1.5,
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
