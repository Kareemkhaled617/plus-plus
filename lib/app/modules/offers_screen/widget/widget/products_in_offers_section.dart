import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/product_details_screen/product_details_screen.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/widgets/loader.dart';
import '../../../../core/widgets/product_item.dart';
import '../../../../routes/app_routes.dart';
import '../../controller/discount_controller.dart';

class ProductsInOffersSection extends StatelessWidget {
  const ProductsInOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiscountController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: AppLoader());
      }
      if (controller.discountProducts.isEmpty) {
        return Container();
      }
      return SizedBox(
        height: 244,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.productDetails, arguments: {
                'productId': controller.discountProducts[index].id,
              });
            },
            child: ProductCard(
              imageUrl: controller.discountProducts[index].imageUrl,
              title: controller.discountProducts[index].name,
              stockInfo: "${controller.discountProducts[index].stock} in stock",
              price: "${controller.discountProducts[index].price} L.E",
              onFavorite: () {},
              onAddToCart: () {},
              id: controller.discountProducts[index].id,
              productEntity: controller.discountProducts[index],
            ),
          ),
        ),
      );
    });
  }
}
