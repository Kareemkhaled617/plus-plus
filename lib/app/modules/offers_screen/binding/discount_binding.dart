import 'package:get/get.dart';
import '../../../core/network/api_service.dart';

import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/usecases/get_discount_products_usecase.dart';
import '../controller/discount_controller.dart';

class DiscountBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure ApiService is available
    Get.lazyPut<ApiService>(() => ApiService());

    // Repository
    Get.lazyPut<ProductRepository>(
        () => ProductRepositoryImpl(Get.find<ApiService>()));

    // UseCase
    Get.lazyPut<GetDiscountProductsUseCase>(
        () => GetDiscountProductsUseCase(Get.find<ProductRepository>()));

    // Controller
    Get.put(DiscountController(Get.find<GetDiscountProductsUseCase>()));
  }
}
