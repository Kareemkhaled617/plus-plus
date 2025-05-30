import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/core/widgets/loader.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../../../core/theme/app_fonts.dart';
import '../../../../core/widgets/product_item.dart';
import '../../controller/discount_controller.dart';

class AllDiscountProductsScreen extends StatelessWidget {
  const AllDiscountProductsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DiscountController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Let flexibleSpace handle it
        title: Text(
          AppKeys.discount,
          style: AppFonts.heading1.copyWith(fontSize: 18),
        ),
        leading: AppBarBackButton(),
        flexibleSpace: Container(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: AppLoader());
          } else if (controller.discountProducts.isEmpty) {
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  childAspectRatio: .8,
                ),
                itemCount: controller.discountProducts.length,
                // Adjust count dynamically
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.productDetails, arguments: {
                        'productId': controller.discountProducts[index].id,
                      });
                    },
                    child: ProductCard(
                      imageUrl: controller.discountProducts[index].imageUrl,
                      title: controller.discountProducts[index].name,
                      stockInfo: "${controller.discountProducts[index].stock} in stock",
                      price: controller.discountProducts[index].price.toString(),
                      onFavorite: () {},
                      onAddToCart: () {},
                      id: controller.discountProducts[index].id,
                      productEntity: controller.discountProducts[index],
                    ),
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
