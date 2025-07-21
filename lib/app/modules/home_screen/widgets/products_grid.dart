import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/product_item.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../../domain/entities/favorite_entity.dart';
import '../../../domain/entities/product_entity.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.products});

  final List<FavouriteEntity> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          childAspectRatio: .77,
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
            id: product.productId,
            productEntity: ProductEntity(
                id: product.productId,
                name: product.name,
                imageUrl: product.imageUrl,
                description: product.description.toString(),
                benefits: [],
                price: product.price,
                stock: product.stock,
                bodyImages: [],
                brandId: 0,
                brandName: '',
                brandImage: '',
                categories: [],
                packageTypes: [],
                discountType: '',
                discountValue: 0,
                discountEndDate: '',
                discountId: null,
                offerType: '',
                offerDiscountPercentage: null,
                offerId: null),
          );
        },
      ),
    );
  }
}
