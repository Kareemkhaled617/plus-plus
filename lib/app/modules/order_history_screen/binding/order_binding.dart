import 'package:get/get.dart';
import '../../../data/repositories/order_repository_impl.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../core/network/api_service.dart';
import '../controller/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl(Get.find<ApiService>()));
    Get.lazyPut(() => OrderController(Get.find<OrderRepository>()));
  }
}
