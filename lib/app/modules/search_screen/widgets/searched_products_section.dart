import 'package:flutter/material.dart';

import '../../../core/widgets/product_item.dart';
import '../../../domain/entities/product_entity.dart';
import '../../home_screen/widgets/products_grid.dart';

class SearchedProductsSection extends StatelessWidget {
  const SearchedProductsSection({
    super.key,
    required this.products,
  });

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        childAspectRatio: .52,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          imageUrl: product.imageUrl,
          title: product.name,
          stockInfo: "${product.stock} in stock",
          price: "${product.price} L.E",
          onFavorite: () {},
          onAddToCart: () {},
          id: product.id, productEntity: product,
        );
      },
    );
  }
}
