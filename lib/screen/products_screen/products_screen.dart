import 'package:flutter/material.dart';
import 'package:plus/components/app_bar_back_button.dart';
import '../../generated/assets.dart';
import '../../utils/app_fonts.dart';
import '../../components/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.gradientColors, this.category});

  /// Two Colors light and dark for Gradient Background
  final List<Color> gradientColors;

  final dynamic category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            gradientColors.isEmpty ? Colors.white : gradientColors[0],
        title: Text(
           "Vaseline",
          style: AppFonts.heading3,
        ),
        leading: AppBarBackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: gradientColors.isEmpty? null : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    childAspectRatio: .65,
                  ),
                  itemCount: 10, // Adjust count dynamically
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imageUrl: Assets.tempDsd,
                      title: "Evy Baby",
                      stockInfo: "Suncream",
                      price: "45 L.E",
                      onAddToCart: () {},
                      onFavorite: () {},
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
