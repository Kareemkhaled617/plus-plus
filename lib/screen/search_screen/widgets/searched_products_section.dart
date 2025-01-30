import 'package:flutter/material.dart';

import '../../../components/product_item.dart';
import '../../../generated/assets.dart';

class SearchedProductsSection extends StatelessWidget {
  const SearchedProductsSection({
    super.key,
    this.products,
  });

  final List<dynamic>? products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
    );
  }
}
