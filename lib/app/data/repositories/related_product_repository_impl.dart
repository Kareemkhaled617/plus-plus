import 'package:plus/app/domain/entities/product_entity.dart';

import '../../core/network/api_service.dart';
import '../../domain/repositories/related_product_repository.dart';
import '../models/product_model.dart';

class RelatedProductRepositoryImpl extends RelatedProductRepository {
  final ApiService apiService;

  RelatedProductRepositoryImpl(this.apiService);

  @override
  Future<List<ProductEntity>> getRelatedProducts() async {
    final response = await apiService.getRequest("cart/related-products");
    final List data = response.data['data'];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
