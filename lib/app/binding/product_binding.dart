import 'package:get/get.dart';

import '../core/network/api_service.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/usecases/get_products_by_category_usecase.dart';
import '../modules/sub_category/controller/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<ProductRepository>(
        () => ProductRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<GetProductsByCategoryUseCase>(
        () => GetProductsByCategoryUseCase(Get.find<ProductRepository>()));

    Get.put(ProductController(Get.find<GetProductsByCategoryUseCase>()));
  }
}
