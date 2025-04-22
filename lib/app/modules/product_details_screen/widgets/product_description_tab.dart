import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_benefit_item.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../controller/product_controller.dart';

class ProductDescriptionTab extends StatelessWidget {
  const ProductDescriptionTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.product.value!.name,
            style: AppFonts.heading1.copyWith(fontSize: 14),
          ),
          Text(
            controller.product.value!.categories[0].name,
            style: AppFonts.heading1
                .copyWith(fontSize: 14, color: AppColors.primary),
          ),
          SizedBox(height: 8),
          // Description

          Text(
            controller.product.value!.description,
            style: TextStyle(
                fontSize: 14, color: AppColors.greyWithShade.withOpacity(.5)),
          ),
          SizedBox(height: 16),
          Text(
            "Benefits".tr,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...List.generate(
              controller.product.value!.benefits.length,
              (index) => ProductBenefitItem(
                  text: controller.product.value!.benefits[index])),
        ],
      ),
    );
  }
}
