import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/size_config.dart';
import 'package:plus/app/core/widgets/cached_image.dart';
import 'package:plus/app/core/widgets/custom_bottom_sheet.dart';
import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../../product_details_screen/widgets/product_counter_section.dart';
import '../controller/cart_controller.dart';
import '../../../domain/entities/product_entity.dart';

class CartListItem extends StatelessWidget {
  final ProductEntity product;
  final bool fromCart;

  const CartListItem(
      {super.key, required this.product, required this.fromCart});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.greyWithShade.withOpacity(.3),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.productDetails, arguments: {
                    'productId': product.id,
                  });
                },
                child: CachedImage(
                  imageUrl: product.imageUrl,
                  width: 100,
                  height: 104,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                    width: getProportionateScreenWidth(120),
                    child: Text(
                      product.name,
                      maxLines: 2,
                      style: AppFonts.heading1.copyWith(fontSize: 14),
                    ),
                  ),
                  Text(
                    product.brandName,
                    style: AppFonts.heading1
                        .copyWith(fontSize: 12, color: AppColors.red),
                  ),
                  SizedBox(height: 12),
                  Obx(() {
                    return Row(
                      children: [
                        Text(
                          "${cartController.getProductCount(product.id)} ${AppKeys.peace.tr}",
                          style: AppFonts.heading1.copyWith(
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(60)),
                        product.isSelected
                            ? Text(
                                "${((product.packageTypes.first.unitPrice) * (cartController.getProductCount(product.id))).toStringAsFixed(2)} L.E",
                                style: AppFonts.heading1.copyWith(
                                    fontSize: 14,
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w700),
                              )
                            : Text(
                                "${((product.discountType == 'discount' ? (product.price - (product.price * (product.discountValue / 100))) : product.price) * (cartController.getProductCount(product.id))).toStringAsFixed(2)} L.E",
                                style: AppFonts.heading1.copyWith(
                                    fontSize: 14,
                                    color: AppColors.red,
                                    fontWeight: FontWeight.w700),
                              ),
                      ],
                    );
                  }),
                  fromCart ? SizedBox(height: 10) : Container(),
                  fromCart
                      ? ProductCounterSection(
                          plusIconSize: 16,
                          controller: cartController,
                          productEntity: product,
                          isSelected: product.isSelected,
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
        fromCart
            ? Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    showCustomBottomSheet(context,
                        buildDeleteItemDialogContent(cartController, product));
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(10),
                        bottomStart: Radius.circular(10),
                      ),
                      color: AppColors.primary,
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                ),
              )
            : Container(),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.all(6),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              ),
            ),
            child: Image.asset(
              product.discountType == 'discount'
                  ? 'assets/icons/discount.png'
                  : product.offerType == 'buy_one_get_two'
                      ? 'assets/icons/2by1.png'
                      : 'assets/icons/1by1.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  buildDeleteItemDialogContent(
      CartController controller, ProductEntity product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          AppKeys.youWantToDelete.tr,
          style: AppFonts.heading3
              .copyWith(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {
                  controller.removeAllProductFromCart(product.id);
                  controller.addToCartApi();
                  Get.back();
                },
                text: AppKeys.sure.tr,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.red),
                ),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    AppKeys.cancel.tr,
                    style: AppFonts.bodyText.copyWith(color: AppColors.red),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
