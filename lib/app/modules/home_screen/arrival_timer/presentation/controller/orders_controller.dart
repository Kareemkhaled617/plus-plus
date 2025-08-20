// lib/app/modules/home_screen/controller/orders_controller.dart
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../domain/entities/order_entity.dart';
import '../../../../../domain/usecases/get_orders_usecase.dart';


class OrdersController extends GetxController {
  final GetOrdersUseCase getOrdersUseCase;
  OrdersController(this.getOrdersUseCase);

  final isLoading = false.obs;
  final orders = <OrderEntity>[].obs;
  final todayOrders = <OrderEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    final res = await getOrdersUseCase();
    res.fold(
          (f) {
        isLoading.value = false;
        // show error if needed
      },
          (list) {
        orders.assignAll(list);
        _filterToday(list);
        isLoading.value = false;
      },
    );
  }

  void _filterToday(List<OrderEntity> list) {
    final now = DateTime.now();
    final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');

    final filtered = list.where((o) {
      final s = (o.estimatedDeliveryTime ?? '').toString();
      DateTime? dt;
      try {
        dt = fmt.parse(s, true).toLocal();
      } catch (_) {
        try { dt = DateTime.parse(s); } catch (_) {}
      }
      if (dt == null) return false;
      return dt.year == now.year && dt.month == now.month && dt.day == now.day;
    }).toList();

    // Optional: keep only active-like statuses
    filtered.sort((a, b) => (a.estimatedDeliveryTime ?? '')
        .compareTo(b.estimatedDeliveryTime ?? ''));

    todayOrders.assignAll(filtered);
  }
}
