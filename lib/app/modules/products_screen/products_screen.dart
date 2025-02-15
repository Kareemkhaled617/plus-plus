import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';

import '../../../generated/assets.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/common_widgets.dart';
import '../../core/widgets/product_item.dart';
import '../product_details_screen/product_details_screen.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen(
      {super.key,
      required this.gradientColors,
      this.category,
      required this.title});

  final List<Color> gradientColors;

  final dynamic category;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            gradientColors.isEmpty ? Colors.white : gradientColors[0],
        title: Text(
          title,
          style: AppFonts.heading2,
        ),
        leading: AppBarBackButton(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: gradientColors.isEmpty
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              childAspectRatio: .65,
            ),
            itemCount: 10, // Adjust count dynamically
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  CommonWidgets.navigateWithFade(ProductDetailsScreen());
                },
                child: ProductCard(
                  imageUrl: Assets.tempDsd,
                  title: "Evy Baby",
                  stockInfo: "Suncream",
                  price: "45 L.E",
                  onAddToCart: () {},
                  onFavorite: () {},
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
