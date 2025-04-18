import 'package:plus/app/domain/entities/product_entity.dart';

import '../repositories/related_product_repository.dart';

class GetRelatedProductsUseCase {
  final RelatedProductRepository repository;

  GetRelatedProductsUseCase(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getRelatedProducts();
  }
}
