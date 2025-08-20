import 'package:get/get.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../data/repositories/order_repository_impl.dart';
import '../../../../../domain/repositories/order_repository.dart';
import '../../../../../domain/usecases/get_orders_usecase.dart';

import '../controller/orders_controller.dart';

class EstimationTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put<OrderRepository>(OrderRepositoryImpl(Get.find<ApiService>()));
    Get.put(GetOrdersUseCase(Get.find<OrderRepository>()));
    Get.put(OrdersController(Get.find<GetOrdersUseCase>()));

  }
}
