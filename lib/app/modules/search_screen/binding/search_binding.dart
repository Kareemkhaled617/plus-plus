import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/usecases/search_products_usecase.dart';

import '../controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    // Inject ApiService instance
    Get.lazyPut<ApiService>(() => ApiService());

    // Inject Repository with the ApiService
    Get.lazyPut<ProductRepositoryImpl>(
        () => ProductRepositoryImpl(Get.find<ApiService>()));

    // Inject UseCase with Repository
    Get.lazyPut<SearchProductsUseCase>(
        () => SearchProductsUseCase(Get.find<ProductRepositoryImpl>()));

    // Inject Controller with UseCase
    Get.lazyPut<SearchProductController>(
        () => SearchProductController(Get.find<SearchProductsUseCase>()));
  }
}
