import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/widgets/cached_image.dart';
import '../../../routes/app_routes.dart';
import '../controller/product_controller.dart';

class ProductBrandItem extends StatelessWidget {
  const ProductBrandItem({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    return ListTile(
      onTap: controller.product.value!.brandName != 'Unknown Brand'
          ? () {
              Navigator.pushNamed(context, AppRoutes.productsScreen,
                  arguments: {
                    "gradientColors": [
                      Colors.white,
                      Colors.white,
                    ],
                    "title": controller.product.value!.brandName,
                    "id": controller.product.value!.brandId,
                    'isSection': false,
                  });
            }
          : null,
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: CachedImage(
          fit: BoxFit.contain,
          imageUrl: controller.product.value!.brandImage,
        ),
      ),
      title: Text(controller.product.value!.brandName,
          style: AppFonts.heading3.copyWith(fontSize: 14)),
    );
  }
}
