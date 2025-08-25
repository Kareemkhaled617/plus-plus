import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/price_widgets.dart';

import '../../domain/entities/product_entity.dart';
import '../../modules/cart/controller/cart_controller.dart';
import '../../modules/favourite_screen/controller/favorite_controller.dart';
import '../../modules/product_details_screen/controller/product_point_controller.dart';
import '../../modules/product_details_screen/widgets/product_counter_section.dart';
import '../../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import '../utils/app_keys.dart';
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
    final controller1 = Get.find<ProductPointController>();
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.productDetails, arguments: {
          'productId': id,
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        margin: const EdgeInsets.symmetric(horizontal: 1),
        width: getProportionateScreenWidth(140),
        height: getProportionateScreenHeight(210),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.greyWithShade.withOpacity(.8),
          //     spreadRadius: .1,
          //   ),
          // ],
        ),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(4),
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CachedImage(
                      height: getProportionateScreenHeight(100),
                      width: getProportionateScreenWidth(200),
                      fit: BoxFit.fill,
                      imageUrl: imageUrl,
                    ),
                    Obx(() {
                      return cartController.isProductInCart(id)
                          ? Align(
                              child: ProductCounterSection(
                                controller: Get.find<CartController>(),
                                productEntity: productEntity,
                              ),
                            )
                          : Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: productEntity.stock == 0
                                    ? () {
                                  showUnAvailableBottomSheet(
                                      productEntity.id,
                                      controller1);
                                }
                                    : () {
                                        if (cartController.isProductInCart(
                                            productEntity.id)) {
                                          Get.snackbar('E Lewaa Store',
                                              'Product already in cart'.tr);
                                        } else {
                                          cartController.addToCart(
                                              productEntity,
                                              isSelect: false);
                                          cartController.addToCartApi();
                                        }
                                      },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primary),
                                  child: productEntity.stock == 0
                                      ? Icon(
                                          Icons.notifications,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            );
                    })
                  ],
                ),

                // productEntity.discountType == 'discount'
                //     ? Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               Container(
                //                 padding: EdgeInsets.all(4),
                //                 decoration: BoxDecoration(
                //                     color: AppColors.primary.withOpacity(.3),
                //                     borderRadius: BorderRadius.circular(4)),
                //                 child: Text(
                //                   '${(productEntity.price -
                //                       (productEntity.price *
                //                           (productEntity.discountValue / 100)))
                //                       .toStringAsFixed(2)} EGP',
                //                   style: AppFonts.bodyText.copyWith(
                //                       fontSize: getResponsiveFontSize(13),
                //                       color: AppColors.red,
                //                       fontWeight: FontWeight.w700),
                //                   maxLines: 1,
                //                   overflow: TextOverflow.ellipsis,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Stack(
                //                 alignment: Alignment.center,
                //                 children: [
                //                   Text(
                //                     price,
                //                     style: AppFonts.bodyText.copyWith(
                //                         fontSize: getResponsiveFontSize(13),
                //                         color: AppColors.grey,
                //                         fontWeight: FontWeight.w700),
                //                     maxLines: 1,
                //                     overflow: TextOverflow.ellipsis,
                //                   ),
                //                   Transform.rotate(
                //                     angle: 180 * (3.14159265359 / 180),
                //                     child: Container(
                //                       height: 2,
                //                       width: 70,
                //                       decoration: BoxDecoration(
                //                         borderRadius: BorderRadius.circular(20),
                //                         color: AppColors.grey,
                //                       ),
                //                     ),
                //                   )
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ],
                //       )
                //     : Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Text(
                //             price,
                //             textAlign: TextAlign.end,
                //             style: AppFonts.bodyText.copyWith(
                //                 fontSize: getResponsiveFontSize(13),
                //                 color: AppColors.black,
                //                 fontWeight: FontWeight.w900),
                //             maxLines: 1,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //         ],
                //       ),

                PriceRow(
                  currency: 'EGP',
                  price: num.parse((productEntity.price -
                          (productEntity.price *
                              (productEntity.discountValue / 100)))
                      .toStringAsFixed(2)),
                  oldPrice: productEntity.discountType == 'discount'
                      ? num.parse(price)
                      : null,
                ),

                Text(
                  title,
                  style: AppFonts.heading1.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.black87.withOpacity(.8),
                    fontSize: getResponsiveFontSize(13),
                    height: 1.2,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // Obx(() {
                //   return ElevatedButton.icon(
                //     onPressed: productEntity.stock == 0
                //         ? null
                //         : () {
                //             if (cartController
                //                 .isProductInCart(productEntity.id)) {
                //               Get.snackbar('E Lewaa Store',
                //                   'Product already in cart'.tr);
                //             } else {
                //               cartController.addToCart(productEntity,
                //                   isSelect: false);
                //               cartController.addToCartApi();
                //             }
                //           },
                //     label: Icon(
                //       cartController.isProductInCart(id)
                //           ? Icons.shopping_cart_rounded
                //           : Icons.shopping_cart_outlined,
                //       size: 22,
                //       color: Colors.white,
                //     ),
                //     icon: cartController.isProductInCart(id)
                //         ? Text(
                //             AppKeys.removeToCart.tr,
                //             style: AppFonts.bodyText.copyWith(
                //               color: Colors.white,
                //               fontSize: getResponsiveFontSize(14),
                //               fontWeight: FontWeight.w700,
                //             ),
                //             maxLines: 1,
                //             overflow: TextOverflow.ellipsis,
                //           )
                //         : Text(
                //             AppKeys.addToCart.tr,
                //             style: AppFonts.bodyText.copyWith(
                //               color: Colors.white,
                //               fontSize: getResponsiveFontSize(14),
                //               fontWeight: FontWeight.w700,
                //             ),
                //             maxLines: 1,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: cartController.isProductInCart(id)
                //           ? AppColors.primary.withOpacity(.2)
                //           : AppColors.primary,
                //       padding: EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: getProportionateScreenWidth(16)),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //   );
                // }),
              ],
            ),
            // Get.locale == Locale('ar')
            //     ? Positioned(
            //         top: -14,
            //         left: -8,
            //         child: Obx(() {
            //           return Row(
            //             children: [
            //               // productEntity.stock == 0
            //               //     ? Text(
            //               //         'Unavailable'.tr,
            //               //         style: AppFonts.bodyText.copyWith(
            //               //             fontSize: 14,
            //               //             fontWeight: FontWeight.w800,
            //               //             color: AppColors.red),
            //               //       )
            //               //     :
            //               productEntity.discountType == 'discount'
            //                   ? Container(
            //                       decoration: BoxDecoration(
            //                           image: DecorationImage(
            //                               image: AssetImage(
            //                                   Assets.imagesBackgroundOffer))),
            //                       child: Text(
            //                         '${productEntity.discountValue} % OFF',
            //                         style: AppFonts.bodyText.copyWith(
            //                             fontSize: getResponsiveFontSize(12),
            //                             fontWeight: FontWeight.w800,
            //                             color: AppColors.red),
            //                       ),
            //                     )
            //                   : Container(),
            //               SizedBox(
            //                 width: getProportionateScreenWidth(50),
            //               ),
            //               IconButton(
            //                 icon: controller.isLoading.value
            //                     ? Container()
            //                     : Icon(
            //                         controller.isProductFavorite(id)
            //                             ? Icons.favorite_rounded
            //                         : Icons.favorite_border,
            //                     color: Colors.red),
            //                 onPressed: controller.isLoading.value
            //                     ? null
            //                     : () {
            //                         controller.addProductToFavorites(id);
            //                         controller.fetchFavourites();
            //                 },
            //               ),
            //             ],
            //           );
            //         }),
            //       )
            //     : Positioned(
            //         top: -3,
            //         right: -10,
            //         child: Obx(() {
            //           return Row(
            //             children: [
            //               // productEntity.stock == 0
            //               //     ? Text(
            //               //         'Unavailable',
            //               //         style: AppFonts.bodyText.copyWith(
            //               //             fontSize: 12,
            //               //             fontWeight: FontWeight.w800,
            //               //             color: AppColors.red),
            //               //       )
            //               //     :
            //               productEntity.discountType == 'discount'
            //                   ? Container(
            //                       height: 50,
            //                       width: 50,
            //                       padding: EdgeInsets.all(6),
            //                       margin: EdgeInsets.all(4),
            //                       alignment: Alignment.center,
            //                       decoration: BoxDecoration(
            //                           image: DecorationImage(
            //                               image: AssetImage(
            //                                   Assets.imagesBackgroundOffer),
            //                               fit: BoxFit.fill)),
            //                       child: Text(
            //                         '${productEntity.discountValue.toInt()} % OFF',
            //                         textAlign: TextAlign.center,
            //                         style: AppFonts.bodyText.copyWith(
            //                             fontSize: getResponsiveFontSize(12),
            //                             fontWeight: FontWeight.w800,
            //                             color: AppColors.white),
            //                       ),
            //                     )
            //                   : Container(),
            //               SizedBox(
            //                 width: getProportionateScreenWidth(30),
            //               ),
            //               IconButton(
            //                 icon: controller.isLoading.value
            //                     ? Container()
            //                     : Icon(
            //                         controller.isProductFavorite(id)
            //                         ? Icons.favorite_rounded
            //                         : Icons.favorite_border,
            //                     color: Colors.red),
            //                 onPressed: controller.isLoading.value
            //                     ? null
            //                     : () {
            //                         controller.addProductToFavorites(id);
            //                   controller.fetchFavourites();
            //                 },
            //               ),
            //             ],
            //           );
            //         }),
            //       ),
            if (productEntity.discountValue > 0)
              Get.locale == Locale('ar')
                  ? Positioned(
                      top: -3,
                      right: -3,
                      child: productEntity.discountType == 'discount'
                          ? Container(
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(20))),
                              child: Text(
                                '${productEntity.discountValue.toInt()} % OFF',
                                textAlign: TextAlign.center,
                                style: AppFonts.bodyText.copyWith(
                                    fontSize: getResponsiveFontSize(10),
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white),
                              ),
                            )
                          : Container(),
                  )
                : Positioned(
                      top: -5,
                      left: -2,
                      child: productEntity.discountType == 'discount'
                          ? Container(
                              padding: EdgeInsets.all(6),
                              margin: EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(20))),
                              child: Text(
                                '${productEntity.discountValue.toInt()} % OFF',
                                textAlign: TextAlign.center,
                                style: AppFonts.bodyText.copyWith(
                                    fontSize: getResponsiveFontSize(10),
                                    fontWeight: FontWeight.w800,
                                  color: AppColors.white),
                            ),
                          )
                        : Container(),
                  ),

            Get.locale == Locale('ar')
                ? Positioned(
                    top: -10,
                    left: -5,
                    child: Obx(() {
                      return IconButton(
                        icon: controller.isLoading.value
                            ? Container()
                            : Icon(
                            controller.isProductFavorite(id)
                                ? Icons.favorite_rounded
                                : Icons.favorite_border,
                                color: controller.isProductFavorite(id)
                                    ? Colors.red
                                    : AppColors.grey),
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                          controller.addProductToFavorites(id);
                          controller.fetchFavourites();
                        },
                      );
                    }),
                  )
                : Positioned(
                    top: -5,
                    right: -5,
                    child: Obx(() {
                      return IconButton(
                        icon: controller.isLoading.value
                            ? Container()
                            : Icon(
                                controller.isProductFavorite(id)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border,
                                color: controller.isProductFavorite(id)
                                    ? Colors.red
                                    : AppColors.grey),
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                controller.addProductToFavorites(id);
                                controller.fetchFavourites();
                              },
                      );
                    }),
                  ),
          ],
        ),
      ),
    );
  }

  void showUnAvailableBottomSheet(int id, ProductPointController controller1) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppKeys.communicate.tr,
              style: AppFonts.heading2,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller1.requestPoint(id);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      AppKeys.yes.tr,
                      style: AppFonts.bodyText.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      AppKeys.no.tr,
                      style: AppFonts.bodyText.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      isDismissible: true,
    );
  }
}
