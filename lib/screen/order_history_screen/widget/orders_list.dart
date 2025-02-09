import 'package:flutter/material.dart';
import 'package:plus/screen/order_details_screen/order_details_screen.dart';
import 'package:plus/screen/order_history_screen/widget/order_card.dart';
import 'package:plus/utils/common_widgets.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        OrderCard(
          status: OrderStatus.completed,
          onTap: () {
            CommonWidgets.navigateWithFade(const OrderDetailsScreen());
          },
        ),
        OrderCard(
          status: OrderStatus.coming,
          onTap: () {
            CommonWidgets.navigateWithFade(const OrderDetailsScreen());
          },
        ),
        OrderCard(
          status: OrderStatus.canceled,
          onTap: () {
            CommonWidgets.navigateWithFade(const OrderDetailsScreen());
          },
        ),
      ],
    );
  }
}
