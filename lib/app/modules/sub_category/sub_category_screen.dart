import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/loader.dart';
import 'package:plus/app/modules/sub_category/widgets/category_tabs.dart';

import '../../../generated/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/widgets/app_bar_back_button.dart';
import '../../core/widgets/product_item.dart';
import '../../routes/app_routes.dart';
import '../product_details_screen/product_details_screen.dart';
import 'controller/product_controller.dart';
import 'controller/sup_category_controller.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({
    super.key,
  });

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  Map categoryData = {};

  @override
  void initState() {
    categoryData = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupCategoryController>();
    final productController = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          categoryData['title'],
          style: AppFonts.heading1,
        ),
        leading: AppBarBackButton(),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: SizedBox(height: 70, child: AppLoader()));
              }
              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CategoryTabs(
                  items: controller.subcategories,
                  selectedIndex: controller.selectedCategory.value,
                  onSelected: (index) async {
                    controller.selectedCategory.value = index;
                    controller.selectedSubcategory.value = -1;
                    controller.fetchSubsSupCategories(
                        controller.subcategories[index].id);
                    productController.fetchProductsByCategory(
                        controller.subcategories[index].id);
                  },
                ),
              );
            }),
            const SizedBox(height: 10),
            Obx(() {
              if (controller.isLoadingSup.value) {
                return SizedBox(height: 70, child: AppLoader());
              }
              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: CategoryTabs(
                  items: controller.supSupCategories,
                  selectedIndex: controller.selectedSubcategory.value,
                  onSelected: (index) {
                    controller.selectedSubcategory.value = index;
                    productController.fetchProductsByCategory(
                        controller.supSupCategories[index].id);
                  },
                  selectedColor: Colors.white,
                  backgroundColor: Colors.white,
                ),
              );
            }),
            SizedBox(height: 10),
            Obx(() {
              if (productController.isLoading.value) {
                return AppLoader();
              }
              if (productController.errorMessage.isNotEmpty) {
                return Center(
                    child: Text(productController.errorMessage.value));
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GridView.builder(
                    cacheExtent: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      childAspectRatio: .8,
                    ),
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      final product = productController.products[index];

                      return ProductCard(
                        imageUrl: product.imageUrl,
                        title: product.name,
                        stockInfo: "${product.stock} ${'in stock'.tr}",
                        price: "${product.price} L.E",
                        onAddToCart: () {},
                        onFavorite: () {},
                        id: product.id, productEntity: product,
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
