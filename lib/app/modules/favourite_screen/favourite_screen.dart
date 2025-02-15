import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/modules/favourite_screen/widgets/favourite_empty_body.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';

import '../home_screen/widgets/products_grid.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> favouriteList = ["Product1"];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          AppKeys.favourite.tr,
          style: AppFonts.heading3,
        ),
        leading: AppBarBackButton(),
      ),
      body: favouriteList.isEmpty ? FavouriteEmptyBody() : ProductsGrid(),
    );
  }
}
