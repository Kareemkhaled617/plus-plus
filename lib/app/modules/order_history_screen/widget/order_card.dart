import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, this.status, this.onTap});

  final Function()? onTap;
  final OrderEntity order;
  final OrderStatus? status;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(.1))),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.babyBlue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.inventory, color: AppColors.primary, size: 30),
            ),
            SizedBox(width: 12),

            // Order Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order ${order.orderNumber}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    order.createdAt,
                    style: AppFonts.hintText.copyWith(fontSize: 12),
                  ),
                  // Text(
                  //   order.,
                  //   style: AppFonts.hintText.copyWith(fontSize: 12),
                  // ),
                ],
              ),
            ),

            // Status and Arrow
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status?.name ?? "Coming",
                    style: AppFonts.bodyText.copyWith(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(width: 12),
                IconButton(
                  onPressed: onTap ?? () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  get statusColor {
    switch (status) {
      case OrderStatus.coming:
        return Colors.red;
      case OrderStatus.completed:
        return AppColors.green;
      case OrderStatus.canceled:
        return AppColors.grey;
      default:
        return Colors.black;
    }
  }
}

enum OrderStatus {
  coming,
  completed,
  canceled,
}
