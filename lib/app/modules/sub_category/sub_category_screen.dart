import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/product_shimmer.dart';
import 'package:plus/app/core/widgets/sub_category_shimmer.dart';
import 'package:plus/app/modules/sub_category/widgets/category_main_tabs.dart';
import 'package:plus/app/modules/sub_category/widgets/category_slider.dart';
import 'package:plus/app/modules/sub_category/widgets/category_tabs.dart';
import 'package:plus/generated/assets.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/widgets/app_bar_back_button.dart';
import '../../core/widgets/product_item.dart';
import 'controller/product_controller.dart';
import 'controller/sup_category_controller.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  Map categoryData = {};

  @override
  void initState() {
    super.initState();
    categoryData = Get.arguments;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupCategoryController>();
    final productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body:
      Obx(() {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: const Color(0xFFb5e8e8),
              leading: const AppBarBackButton(),
              title: Text(
                categoryData['title'] ?? '',
                style: AppFonts.heading1,
              ),
            ),


            SliverPersistentHeader(
              pinned: true, // <- keeps it visible while you scroll
              delegate: _TabsHeaderDelegate(
                height: 110, // tune as needed to fit your content
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesBacgroundCategory),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Obx(() {
                    // we keep the same content you already have
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        controller.isLoading.value
                            ? const SubCategoryShimmer()
                            : controller.errorMessage.isNotEmpty
                                ? Center(
                                    child: Text(controller.errorMessage.value))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: CategoryMainTabs(
                                      items: controller.subcategories,
                                      selectedIndex:
                                          controller.selectedCategory.value,
                                      onSelected: (index) {
                                        controller.selectedCategory.value =
                                            index;
                                        controller.selectedSubcategory.value =
                                            -1;
                                        controller.fetchSubsSupCategories(
                                          controller.subcategories[index].id,
                                        );
                                        productController
                                            .fetchProductsByCategory(
                                          controller.subcategories[index].id,
                                        );
                                      },
                                    ),
                                  ),

                        controller.isLoadingSup.value
                            ? const SubCategoryShimmer()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: CategoryTabs(
                                  items: controller.supSupCategories,
                                  selectedIndex:
                                      controller.selectedSubcategory.value,
                                  onSelected: (index) {
                                    controller.selectedSubcategory.value =
                                        index;
                                    productController.fetchProductsByCategory(
                                      controller.supSupCategories[index].id,
                                    );
                                  },
                                ),
                              ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            /// Slider
             SliverToBoxAdapter(
              child: Obx(() {
                return productController.categoryBanner.value != ''? AutoScrollImageRow(
                  image: productController.categoryBanner.value,
                ):Container();
              }),
            ),

            /// Products Grid
            if (productController.isLoading.value)
              const SliverToBoxAdapter(
                  child: SizedBox(height: 200, child: ProductShimmer()))
            else if (productController.errorMessage.isNotEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Text(productController.errorMessage.value),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final product = productController.products[index];
                      return ProductCard(
                        imageUrl: product.imageUrl,
                        title: product.name,
                        stockInfo: "${product.stock} ${'in stock'.tr}",
                        price: "${product.price}",
                        onAddToCart: () {},
                        onFavorite: () {},
                        id: product.id,
                        productEntity: product,
                      );
                    },
                    childCount: productController.products.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: .44,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class _TabsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _TabsHeaderDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child; // keep it simple; it stays the same size
  }

  @override
  bool shouldRebuild(_TabsHeaderDelegate oldDelegate) =>
      oldDelegate.child != child || oldDelegate.height != height;
}
