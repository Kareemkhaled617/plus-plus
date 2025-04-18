import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/brand_entity.dart';
import '../../modules/products_screen/products_screen.dart';
import '../../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/color_helper.dart';
import 'cached_image.dart';

class BrandsListItem extends StatelessWidget {
  const BrandsListItem({
    super.key,
    required this.brand,
    this.onTap,
  });

  final void Function()? onTap;
  final BrandEntity brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Get.toNamed(AppRoutes.productsScreen, arguments: {
              "gradientColors": [
                Colors.white,
                Colors.white,
              ],
              "title": brand.name,
              "id": brand.id,
              'isSection': false,
            });
          },
      child: Card(
        color: Colors.white,
        elevation: .5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedImage(
            fit: BoxFit.contain,
            imageUrl: brand.imageUrl,
          ),
        ),
      ),
    );
  }
}
