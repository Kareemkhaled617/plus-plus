import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/product_details_screen/controller/product_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/widgets/app_bar_back_button.dart';
import '../../../core/widgets/offers_percent_widget.dart';
import '../../favourite_screen/controller/favorite_controller.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({super.key, required this.controller});

  final ProductDetailsController controller;

  @override
  Widget build(BuildContext context) {
    FavoriteController favoriteController = Get.find<FavoriteController>();

    return Row(
      children: [
        AppBarBackButton(),
        SizedBox(width: 15),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    controller.product.value!.name,
                    maxLines: 1,
                    style: AppFonts.heading1.copyWith(fontSize: 17),
                  ),
                ),
                Text(
                  controller.product.value!.categories[0].name,
                  style: AppFonts.heading1
                      .copyWith(fontSize: 15, color: AppColors.primary),
                ),
              ],
            ),
            controller.product.value!.discountType == "discount"
                ? OffersPercentWidget(
                    percent: controller.product.value!.discountValue
                        .toStringAsFixed(0),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Spacer(),
        Obx(() {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                favoriteController
                    .addProductToFavorites(controller.product.value!.id);
              },
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.grey.withOpacity(.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                    favoriteController
                            .isProductFavorite(controller.product.value!.id)
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    color: Colors.red),
              ),
            ),
          );
        }),
      ],
    );
  }
}
