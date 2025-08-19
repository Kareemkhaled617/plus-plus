import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_counter_section.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/product_controller.dart';

class ProductPriceSection extends StatelessWidget {
  const ProductPriceSection({super.key, required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.product.value!.packageTypes.isNotEmpty
              ? Text(
                  "${controller.product.value!.packageTypes.first.unitQuantity.toStringAsFixed(0)} ${controller.product.value!.packageTypes.first.unitType}",
                  style: AppFonts.heading3.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
          // Spacer(),
          controller.isSelected.value? SizedBox(height: 12,):SizedBox(),
          controller.isSelected.value
              ? Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "${AppKeys.price.tr}:  ",
                      style: AppFonts.heading3,
                      children: [
                        TextSpan(
                          text:
                              "${controller.product.value!.packageTypes.first.unitPrice} L.E",
                          style: AppFonts.heading3.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ]))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.product.value!.discountType == 'discount'
                        ? Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "${AppKeys.price.tr}:  ",
                                  style: AppFonts.heading3,
                                  children: [
                                    TextSpan(
                                      text: (controller.product.value!.price -
                                              (controller.product.value!.price *
                                                  (controller.product.value!
                                                          .discountValue /
                                                      100)))
                                          .toStringAsFixed(2),
                                      style: AppFonts.heading3.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Text(
                                            "  ${controller.product.value!.price} L.E  ",
                                            style: AppFonts.heading3.copyWith(
                                              color: AppColors.red,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration
                                                  .none, // Remove normal line
                                            ),
                                          ),
                                          Positioned(
                                            child: Transform.rotate(
                                              angle: 45 * (3.14159265359 / 180),
                                              // Convert degrees to radians
                                              child: Container(
                                                height: 2,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: AppColors.red,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "${AppKeys.price.tr}:  ",
                                style: AppFonts.heading3,
                                children: [
                                  TextSpan(
                                    text:
                                        "${controller.product.value!.price} L.E",
                                    style: AppFonts.heading3.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ])),
                    controller.product.value!.stock == 0
                        ? Container()
                        : ProductCounterSection(
                            controller: cartController,
                      productEntity: controller.product.value!,
                      isSelected: controller.isSelected.value,
                    ),
                  ],
                ),
        ],
      );
    });
  }
}
