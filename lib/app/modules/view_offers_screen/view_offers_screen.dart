import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/core/widgets/cached_image.dart';
import 'package:plus/app/modules/view_offers_screen/widget/brands_dropdown.dart';
import 'package:plus/generated/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/widgets/loader.dart';
import '../../core/widgets/product_item.dart';
import '../home_screen/widgets/products_grid.dart';
import 'controller/product_offer_controller.dart';

class ViewOffersScreen extends StatelessWidget {
  const ViewOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductOffersController productOffersController =
        Get.find<ProductOffersController>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Get.back(),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.babyBlue.withOpacity(.5),
                  ),
                  child: Column(
                    children: [
                      CachedImage(
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        imageUrl: Get.arguments['imageUrl'],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            color: AppColors.deepRed,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              AppKeys.dontMissOfferChance.tr,
                              style: AppFonts.bodyText.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Image.asset(Assets.iconsOffersPercent, height: 20),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              "Buy one product and you will get the second one free"
                                  .tr,
                              style: AppFonts.bodyText.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BrandsDropdown(),
                ),
                Obx(() {
                  if (productOffersController.isLoading.value) {
                    return AppLoader();
                  }
                  if (productOffersController.errorMessage.isNotEmpty) {
                    return Center(
                        child:
                            Text(productOffersController.errorMessage.value));
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      childAspectRatio: .76,
                    ),
                    itemCount: productOffersController.products.length,
                    itemBuilder: (context, index) {
                      final product = productOffersController.products[index];
                      return ProductCard(
                        imageUrl: product.imageUrl,
                        title: product.name,
                        stockInfo: "${product.stock} in stock",
                        price: "${product.price} L.E",
                        onFavorite: () {},
                        onAddToCart: () {},
                        id: product.id,
                        productEntity: product,
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
