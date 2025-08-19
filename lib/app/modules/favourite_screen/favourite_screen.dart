import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/core/widgets/loader.dart';
import 'package:plus/app/modules/favourite_screen/widgets/favourite_empty_body.dart';
import '../../core/widgets/product_shimmer.dart';
import '../home_screen/widgets/products_grid.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import 'controller/favorite_controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoriteController>();
    controller.fetchFavourites();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(AppKeys.favourite.tr, style: AppFonts.heading1),
        leading: const AppBarBackButton(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return ProductShimmer();
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }
        if (controller.favourites.isEmpty) {
          return const FavouriteEmptyBody();
        }

        return ProductsGrid(products: controller.favourites);
      }),
    );
  }
}
