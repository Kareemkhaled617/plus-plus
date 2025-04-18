import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controller/order_controller.dart';
import 'order_card.dart';

class OrdersList extends StatelessWidget {
  final OrderStatus status;

  const OrdersList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    final orders = {
      OrderStatus.coming: controller.comingOrders,
      OrderStatus.completed: controller.completedOrders,
      OrderStatus.canceled: controller.canceledOrders,
    }[status]!;

    return Obx(() => ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) => OrderCard(
            order: orders[index],
            status: status,
            onTap: () {
              print(orders[index].id);
              print(orders[index].id);
              Get.toNamed(AppRoutes.orderDetailsScreen,
                  arguments: {"orderId": orders[index].id});
            },
          ),
        ));
  }
}
