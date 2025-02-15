import 'package:flutter/material.dart';
import 'package:plus/app/core/widgets/product_item.dart';

import '../../../../generated/assets.dart';
import '../../../core/utils/common_widgets.dart';
import '../../product_details_screen/product_details_screen.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, this.products});

  final List<dynamic>? products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          childAspectRatio: .6,
        ),
        itemCount: 10,
        // Adjust count dynamically
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              CommonWidgets.navigateWithFade(
                ProductDetailsScreen(),
              );
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
    );
  }
}
