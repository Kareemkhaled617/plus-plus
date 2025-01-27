import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/components/custom_button.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String stockInfo;
  final String price;
  final VoidCallback onAddToCart;
  final VoidCallback onFavorite;

  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.stockInfo,
    required this.price,
    required this.onAddToCart,
    required this.onFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Image.asset(
                imageUrl,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppFonts.heading1
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        stockInfo,
                        style: AppFonts.bodyText
                            .copyWith(fontSize: 18, color: AppColors.brown),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    price,
                    style: AppFonts.heading1.copyWith(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onAddToCart,
                label: Icon(
                  Icons.shopping_cart_outlined,
                  size: 26,
                  color: AppColors.white,
                ),
                icon: Text(
                  "Add To Cart".tr,
                  style: AppFonts.bodyText.copyWith(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.red),
              onPressed: onFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
