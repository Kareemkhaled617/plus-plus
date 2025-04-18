import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/usecases/get_product_details_usecase.dart';
import '../../../domain/usecases/get_products_by_section_usecase.dart';
import '../controller/product_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize API service
    final apiService = Get.find<ApiService>();

    // Initialize repository
    final productRepository = ProductRepositoryImpl(apiService);

    // Initialize use cases
    final getProductDetailsUseCase =
        GetProductDetailsUseCase(productRepository);

    // Initialize controller with use cases
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(
        getProductDetailsUseCase,
      ),
    );
  }
}
