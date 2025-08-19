import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/core/widgets/product_shimmer.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../core/theme/app_fonts.dart';
import '../../core/widgets/product_item.dart';
import 'controller/product_controller.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    required this.gradientColors,
    this.category,
    required this.title,
  });

  final List<Color> gradientColors;

  final dynamic category;
  final String title;

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Let flexibleSpace handle it
        title: Text(
          title,
          style: AppFonts.heading1.copyWith(fontSize: 18),
        ),
        leading: AppBarBackButton(),
        flexibleSpace: gradientColors.isEmpty
            ? Container(color: Colors.white)
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: gradientColors.isEmpty
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return ProductShimmer();
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  childAspectRatio: .44,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.productDetails);
                    },
                    child: ProductCard(
                      imageUrl: controller.products[index].imageUrl,
                      title: controller.products[index].name,
                      stockInfo: "${controller.products[index].stock} in stock",
                      price: controller.products[index].price.toString(),
                      onFavorite: () {},
                      onAddToCart: () {},
                      id: controller.products[index].id,
                      productEntity: controller.products[index],
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
