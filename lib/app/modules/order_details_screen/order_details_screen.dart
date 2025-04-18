import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/order_details_screen/controller/order_details_controller.dart';
import 'package:plus/app/modules/order_details_screen/widget/general_info_section.dart';
import 'package:plus/app/modules/order_details_screen/widget/order_tracking_section.dart';
import 'package:plus/app/modules/order_details_screen/widget/payment_info_section.dart';
import 'package:plus/app/modules/order_details_screen/widget/rewards_section.dart';
import 'package:plus/app/modules/order_details_screen/widget/shipping_details_section.dart';
import 'package:plus/generated/assets.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(AppKeys.orderDetails.tr, style: AppFonts.heading2),
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            color: AppColors.white,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final order = controller.order.value!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rewards Section
                  RewardsSection(
                    orderEntity: order,
                  ),
                  SizedBox(height: 20),

                  // General Info Section
                  GeneralInfoSection(
                    orderEntity: order,
                  ),
                  SizedBox(height: 20),

                  // Shipping Details Section
                  ShippingDetailsSection(
                    orderEntity: order,
                  ),
                  SizedBox(height: 20),

                  PaymentInfoSection(  orderEntity: order,),
                  SizedBox(
                    height: 20,
                  ),
                  OrderTrackingSection(orderEntity: order),
                ],
              ),
            ),
          );
        }));
  }
}
