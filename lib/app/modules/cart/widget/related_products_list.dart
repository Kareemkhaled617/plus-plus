import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/loader.dart';

import '../../../../generated/assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/widgets/product_item.dart';
import '../../../routes/app_routes.dart';
import '../controller/related_product_controller.dart';

class RelatedProductsList extends StatelessWidget {
  const RelatedProductsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RelatedProductController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: AppLoader());
      }
      if (controller.relatedProducts.isEmpty) {
        return Container();
      }

      return Column(
        children: [
          Row(
            children: [
              Text(
                AppKeys.relatedProducts.tr,
                style: AppFonts.heading2,
              ),
              Spacer(),
              // InkWell(
              //   onTap: () {
              //     Navigator.pushNamed(context, AppRoutes.productsScreen,
              //         arguments: {
              //           "gradientColors": [AppColors.white, AppColors.white],
              //           "title": 'Related Products'.tr,
              //         });
              //   },
              //   child: Text(
              //     AppKeys.viewAll.tr,
              //     style: AppFonts.bodyText.copyWith(
              //         color: AppColors.primary,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w500),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
                itemCount: controller.relatedProducts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ProductCard(
                      imageUrl: controller.relatedProducts[index].imageUrl,
                      title: controller.relatedProducts[index].name,
                      stockInfo:
                          "${controller.relatedProducts[index].stock} in stock",
                      price: "${controller.relatedProducts[index].price} L.E",
                      onAddToCart: () {},
                      onFavorite: () {},
                      id: controller.relatedProducts[index].id,
                      productEntity: controller.relatedProducts[index],
                    )),
          )
        ],
      );
    });
  }
}
