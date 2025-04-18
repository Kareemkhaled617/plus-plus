import 'package:plus/app/domain/entities/product_entity.dart';

abstract class RelatedProductRepository {
  Future<List<ProductEntity>> getRelatedProducts();
}
