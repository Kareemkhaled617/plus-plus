import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/cart/cart_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import '../utils/size_config.dart';
import 'offers_percent_widget.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String stockInfo;
  final String price;
  final VoidCallback? onAddToCart;
  final VoidCallback onFavorite;
  final bool isOffer;

  const ProductCard({
    required this.imageUrl,
    required this.title,
    required this.stockInfo,
    required this.price,
     this.onAddToCart,
    required this.onFavorite,
    this.isOffer = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyWithShade.withOpacity(.8),
              spreadRadius: .1,
            )
          ]),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
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
                        style: AppFonts.heading1.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: getResponsiveFontSize(16),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        stockInfo,
                        style: AppFonts.bodyText.copyWith(
                          fontSize: getResponsiveFontSize(13),
                          color: AppColors.brown,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                  Text(
                    price,
                    style: AppFonts.heading1
                        .copyWith(fontSize: getResponsiveFontSize(15)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onAddToCart ?? () {
                  Get.to(CartScreen());
                },
                label: Icon(
                  Icons.shopping_cart_outlined,
                  size: 26,
                  color: AppColors.white,
                ),
                icon: Text(
                  "Add To Cart".tr,
                  style: AppFonts.bodyText.copyWith(
                      color: AppColors.white,
                      fontSize: getResponsiveFontSize(15),
                      fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
            right: -14,
            child: IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.red),
              onPressed: onFavorite,
            ),
          ),
          if (isOffer)
            Positioned(
              top: 0,
              left: 0,
              child: OffersPercentWidget(),
            ),
        ],
      ),
    );
  }
}
