import 'package:get/get.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/repositories/order_repository.dart';

class OrderController extends GetxController {
  final OrderRepository repository;

  OrderController(this.repository);

  var isLoading = false.obs;
  var completedOrders = <OrderEntity>[].obs;
  var comingOrders = <OrderEntity>[].obs;
  var canceledOrders = <OrderEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  void loadOrders() async {
    isLoading.value = true;
    try {
      completedOrders.value = await repository.getOrdersByStatus('completed');
      comingOrders.value = await repository.getOrdersByStatus('un-completed');
      canceledOrders.value = await repository.getOrdersByStatus('canceled');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    isLoading.value = false;
  }
}
