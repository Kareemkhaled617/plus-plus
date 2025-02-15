import 'package:flutter/material.dart';

import '../../../core/utils/common_widgets.dart';
import '../../order_details_screen/order_details_screen.dart';
import 'order_card.dart';


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
