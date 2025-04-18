import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/related_product_repository_impl.dart';
import '../../../domain/repositories/related_product_repository.dart';
import '../../../domain/usecases/get_related_products_usecase.dart';
import '../controller/related_product_controller.dart';

class RelatedProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<RelatedProductRepository>(
        () => RelatedProductRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetRelatedProductsUseCase(Get.find()));
    Get.lazyPut(() => RelatedProductController(Get.find()));
  }
}
