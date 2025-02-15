import 'package:flutter/material.dart';

import '../../../components/product_item.dart';
import '../../home_screen/widgets/products_grid.dart';
import '../../../generated/assets.dart';

class SearchedProductsSection extends StatelessWidget {
  const SearchedProductsSection({
    super.key,
    this.products,
  });

  final List<dynamic>? products;

  @override
  Widget build(BuildContext context) {
    return ProductsGrid();
  }
}
