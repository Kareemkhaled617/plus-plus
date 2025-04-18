import 'package:get/get.dart';
import 'package:plus/app/modules/products_screen/controller/product_controller.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/usecases/get_products_by_brand_usecase.dart';
import '../../../domain/usecases/get_products_by_section_usecase.dart';

class AllProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<ProductRepository>(
        () => ProductRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<GetProductsByBrandUseCase>(() => GetProductsByBrandUseCase(
          repository: Get.find<ProductRepository>(),
        ));
    Get.lazyPut<GetProductsBySectionUseCase>(() => GetProductsBySectionUseCase(
          repository: Get.find<ProductRepository>(),
        ));

    Get.put(ProductController(Get.find<GetProductsByBrandUseCase>(),
        Get.find<GetProductsBySectionUseCase>()));
  }
}
