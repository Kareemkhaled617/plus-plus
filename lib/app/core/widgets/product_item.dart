import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';

import '../../domain/entities/product_entity.dart';
import '../../modules/cart/controller/cart_controller.dart';
import '../../modules/favourite_screen/controller/favorite_controller.dart';
import '../../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import '../utils/size_config.dart';
import 'cached_image.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final int id;
  final String title;
  final String stockInfo;
  final String price;
  final ProductEntity productEntity;
  final VoidCallback? onAddToCart;
  final VoidCallback onFavorite;
  final bool isOffer;

  const ProductCard({
    required this.imageUrl,
    required this.id,
    required this.title,
    required this.stockInfo,
    required this.price,
    this.onAddToCart,
    required this.onFavorite,
    this.isOffer = false,
    super.key,
    required this.productEntity,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoriteController>();
    CartController cartController = Get.find<CartController>();

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.productDetails, arguments: {
          'productId': id,
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: getProportionateScreenWidth(160),
        // height: getProportionateScreenHeight(220),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyWithShade.withOpacity(.8),
              spreadRadius: .1,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                CachedImage(
                  height: 60,
                  fit: BoxFit.contain,
                  imageUrl: imageUrl,
                ),

                SizedBox(height: getProportionateScreenHeight(10)),

                /// **Price & Stock (Space Between)**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            stockInfo,
                            style: AppFonts.bodyText.copyWith(
                                fontSize: getResponsiveFontSize(13),
                                color: AppColors.brown,
                                fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    productEntity.discountType == 'discount'
                        ? Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    price,
                                    style: AppFonts.bodyText.copyWith(
                                        fontSize: getResponsiveFontSize(10),
                                        color: AppColors.red,
                                        fontWeight: FontWeight.w700),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Transform.rotate(
                                    angle: 45 * (3.14159265359 / 180),
                                    // Convert degrees to radians
                                    child: Container(
                                      height: 2,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                (productEntity.price -
                                        (productEntity.price *
                                            (productEntity.discountValue /
                                                100)))
                                    .toStringAsFixed(2),
                                style: AppFonts.bodyText.copyWith(
                                    fontSize: getResponsiveFontSize(13),
                                    fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        : Text(
                            price,
                            style: AppFonts.bodyText.copyWith(
                                fontSize: getResponsiveFontSize(13),
                                fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ],
                ),

                SizedBox(height: getProportionateScreenHeight(14)),

                /// **Add To Cart Button**
                Obx(() {
                  return ElevatedButton.icon(
                    onPressed: productEntity.stock == 0
                        ? null
                        : () {
                            if (cartController
                                .isProductInCart(productEntity.id)) {
                              Get.snackbar(
                                  'PLUS', 'Product already in cart'.tr);
                            } else {
                              cartController.addToCart(productEntity,
                                  isSelect: false);
                              cartController.addToCartApi();
                            }
                          },
                    label: Icon(
                      cartController.isProductInCart(id)
                          ? Icons.shopping_cart_rounded
                          : Icons.shopping_cart_outlined,
                      size: 22,
                      color: Colors.white,
                    ),
                    icon: cartController.isProductInCart(id)
                        ? Text(
                            AppKeys.removeToCart.tr,
                            style: AppFonts.bodyText.copyWith(
                              color: Colors.white,
                              fontSize: getResponsiveFontSize(14),
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Text(
                            AppKeys.addToCart.tr,
                            style: AppFonts.bodyText.copyWith(
                              color: Colors.white,
                              fontSize: getResponsiveFontSize(14),
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cartController.isProductInCart(id)
                          ? AppColors.primary.withOpacity(.2)
                          : AppColors.primary,
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: getProportionateScreenWidth(16)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }),
              ],
            ),
            Get.locale == Locale('ar')
                ? Positioned(
                    top: -14,
                    left: -12,
                    child: Obx(() {
                      return Row(
                        children: [
                          productEntity.stock == 0
                              ? Text(
                                  'Unavailable'.tr,
                                  style: AppFonts.bodyText.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.red),
                                )
                              : productEntity.discountType == 'discount'
                                  ? Text(
                                      '${productEntity.discountValue} % OFF',
                                      style: AppFonts.bodyText.copyWith(
                                          fontSize: getResponsiveFontSize(12),
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.red),
                                    )
                                  : Container(),
                          SizedBox(
                            width: getProportionateScreenWidth(50),
                          ),
                          IconButton(
                            icon: controller.isLoading.value
                                ? Container()
                                : Icon(
                                    controller.isProductFavorite(id)
                                        ? Icons.favorite_rounded
                                    : Icons.favorite_border,
                                color: Colors.red),
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    controller.addProductToFavorites(id);
                                    controller.fetchFavourites();
                            },
                          ),
                        ],
                      );
                    }),
                  )
                : Positioned(
                    top: -14,
                    right: -14,
                    child: Obx(() {
                      return Row(
                        children: [
                          productEntity.stock == 0
                              ? Text(
                                  'Unavailable',
                                  style: AppFonts.bodyText.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.red),
                                )
                              : productEntity.discountType == 'discount'
                                  ? Text(
                                      '${productEntity.discountValue} % OFF',
                                      style: AppFonts.bodyText.copyWith(
                                          fontSize: getResponsiveFontSize(12),
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.red),
                                    )
                                  : Container(),
                          SizedBox(
                            width: getProportionateScreenWidth(40),
                          ),
                          IconButton(
                            icon: controller.isLoading.value
                                ? Container()
                                : Icon(
                                    controller.isProductFavorite(id)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border,
                                color: Colors.red),
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    controller.addProductToFavorites(id);
                              controller.fetchFavourites();
                            },
                          ),
                        ],
                      );
                    }),
                  ),
          ],
        ),
      ),
    );
  }
}
