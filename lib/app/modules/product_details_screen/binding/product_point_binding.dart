import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/usecases/request_product_point_usecase.dart';
import '../../../domain/repositories/product_repository.dart';
import '../controller/product_point_controller.dart';
class ProductPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(Get.find()));
    Get.lazyPut(() => RequestProductPointUseCase(Get.find()));
    Get.lazyPut(() => ProductPointController(Get.find()));
  }
}
