import 'package:get/get.dart';
import '../../../data/repositories/order_repository_impl.dart';
import '../../../domain/repositories/order_repository.dart';
import '../../../core/network/api_service.dart';
import '../../../domain/usecases/cancel_order_usecase.dart';
import '../../../domain/usecases/get_order_details_usecase.dart';
import '../controller/order_details_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // Inject ApiService only once
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    // Repository
    Get.lazyPut<OrderRepository>(
        () => OrderRepositoryImpl(Get.find<ApiService>()));

    // UseCase
    Get.lazyPut<GetOrderDetailsUseCase>(
        () => GetOrderDetailsUseCase(Get.find<OrderRepository>()));
    Get.lazyPut<CancelOrderUseCase>(
        () => CancelOrderUseCase(Get.find<OrderRepository>()));

    // Controller
    Get.lazyPut<OrderDetailsController>(() => OrderDetailsController(
        Get.find<GetOrderDetailsUseCase>(), Get.find<CancelOrderUseCase>()));
  }
}
