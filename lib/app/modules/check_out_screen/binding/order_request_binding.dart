import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/order_repository_impl.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../domain/usecases/CalculateOrderPriceUseCase.dart';
import '../../../domain/usecases/create_order_usecase.dart';
import '../controller/check_out_controller.dart'; // assuming you're using ApiService class for API handling

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    // ✅ Inject ApiService (if not already injected elsewhere globally)
    Get.lazyPut<ApiService>(() => ApiService());

    // ✅ Inject Repository
    Get.lazyPut<OrderRepository>(
        () => OrderRepositoryImpl(Get.find<ApiService>()));

    // ✅ Inject UseCase
    Get.lazyPut(() => CreateOrderUseCase(Get.find<OrderRepository>()));
    Get.lazyPut(() => CalculateOrderPriceUseCase(Get.find<OrderRepository>()));

    // ✅ Inject Controller
    Get.lazyPut(() => CheckoutController(Get.find<CreateOrderUseCase>(),
        Get.find<CalculateOrderPriceUseCase>()));
  }
}
