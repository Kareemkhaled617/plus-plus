import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/cart_repository_impl.dart';
import '../../../domain/repositories/cart_repository.dart';
import '../../../domain/usecases/add_to_cart_usecase.dart';
import '../../../domain/usecases/get_cart_total_usecase.dart';
import '../../../domain/usecases/get_cart_usecase.dart';
import '../../../domain/usecases/remove_from_cart_use_case.dart';
import '../../../domain/usecases/remove_from_cart_usecase.dart';
import '../controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut<CartRepository>(() => CartRepositoryImpl(Get.find()));
    Get.lazyPut(() => AddToCartUseCase(Get.find()));
    Get.lazyPut(() => RemoveAllFromCartUseCase(Get.find()));
    Get.lazyPut(() => GetCartUseCase(Get.find()));
    Get.lazyPut(() => RemoveFromCartUseCase(Get.find()));
    Get.lazyPut(() => GetCartTotalUseCase(Get.find()));
    Get.lazyPut(() => CartController(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
