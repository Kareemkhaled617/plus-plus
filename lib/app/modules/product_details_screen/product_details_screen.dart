import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_counter_section.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_description_and_brand_section.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_details_header.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_images_section.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_price_section.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_types_section.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../core/utils/size_config.dart';
import '../../core/widgets/loader.dart';
import '../cart/controller/cart_controller.dart';
import 'controller/product_controller.dart';
import 'controller/product_point_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();
    CartController cartController = Get.find<CartController>();
    final controller1 = Get.find<ProductPointController>();
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: AppLoader());
            }
            if (controller.product.value == null) {
              return Center(child: Text(controller.errorMessage.value));
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDetailsHeader(
                        controller: controller,
                      ),
                      ProductImagesSection(
                        controller: controller,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Colors.grey.shade300.withOpacity(.5),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      controller.product.value!.stock == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    showUnAvailableBottomSheet(
                                        controller.product.value!.id,
                                        controller1);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    minimumSize: Size(220, 56),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.red.withOpacity(.3),
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: Text(
                                    AppKeys.unAvailable.tr,
                                    style: AppFonts.bodyText.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  AppKeys.whatDoYouNeed.tr,
                                  style: AppFonts.heading2.copyWith(
                                      fontSize: getResponsiveFontSize(15)),
                                ),
                                ProductTypesSection(
                                  controller: controller,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ProductCounterSection(
                                    controller: cartController,
                                    productEntity: controller.product.value!,
                                    isSelected: controller.isSelected.value,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ProductPriceSection(controller: controller),
                              ],
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      ProductDescriptionAndBrandSection(),
                  ]),
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        return controller.isLoading.value
            ? Container()
            : controller.product.value != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 90),
                child: ElevatedButton.icon(
                  onPressed: controller.product.value!.stock == 0
                      ? null
                      : () {
                          if (cartController
                              .isProductInCart(controller.product.value!.id)) {
                            cartController.removeAllProductFromCart(
                                controller.product.value!.id);
                          } else {
                            cartController.addToCart(controller.product.value!,
                                isSelect: controller.isSelected.value);
                          }
                        },
                  label: Icon(
                    cartController.isProductInCart(controller.product.value!.id)
                        ? Icons.delete_outline_rounded
                        : Icons.shopping_cart_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                  icon: cartController
                          .isProductInCart(controller.product.value!.id)
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
                    backgroundColor: cartController
                            .isProductInCart(controller.product.value!.id)
                        ? AppColors.red
                        : AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                  )
                : Container();
      }),
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
