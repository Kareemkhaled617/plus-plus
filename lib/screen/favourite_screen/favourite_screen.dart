import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/components/app_bar_back_button.dart';
import 'package:plus/screen/home_screen/widgets/products_grid.dart';
import 'package:plus/screen/favourite_screen/widgets/favourite_empty_body.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_keys.dart';
import '../../utils/app_fonts.dart';

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
