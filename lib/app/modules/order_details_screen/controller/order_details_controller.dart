import 'package:get/get.dart';

import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/cancel_order_usecase.dart';
import '../../../domain/usecases/get_order_details_usecase.dart';

class OrderDetailsController extends GetxController {
  final GetOrderDetailsUseCase useCase;
  final CancelOrderUseCase cancelOrderUseCase;

  OrderDetailsController(this.useCase, this.cancelOrderUseCase);

  var isLoading = true.obs;
  var order = Rxn<OrderEntity>();

  @override
  void onInit() {
    super.onInit();
    final id = Get.arguments["orderId"];
    if (id != null) fetchOrderDetails(id);
  }

  Future<void> fetchOrderDetails(int orderId) async {
    print('===========================================');
    print(Get.arguments["orderId"]);
    isLoading.value = true;
    order.value = await useCase(orderId);
    isLoading.value = false;
  }

  Future<void> cancelOrder(int orderId) async {
    final success = await cancelOrderUseCase(orderId);
    if (success) {
      Get.back();
      Get.snackbar("Success".tr, "Order canceled successfully".tr);

    } else {
      Get.snackbar("Error".tr, "Failed to cancel order".tr);
    }
  }
}
