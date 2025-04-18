import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/usecases/get_products_by_offer_and_brand_usecase.dart';
import '../controller/product_offer_controller.dart';

class ProductOffersBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = Get.find<ApiService>();
    final productRepository = ProductRepositoryImpl(apiService);
    final getProductsByOfferAndBrandUseCase =
        GetProductsByOfferAndBrandUseCase(productRepository);

    Get.lazyPut<ProductOffersController>(
      () => ProductOffersController(
          getProductsByOfferAndBrandUseCase: getProductsByOfferAndBrandUseCase),
    );
  }
}
