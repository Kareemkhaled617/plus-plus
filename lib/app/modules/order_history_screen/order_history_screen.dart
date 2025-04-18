import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/modules/order_history_screen/widget/history_empty_body.dart';
import 'package:plus/app/modules/order_history_screen/widget/order_card.dart';
import 'package:plus/app/modules/order_history_screen/widget/orders_list.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import 'controller/order_controller.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final orderController = Get.find<OrderController>();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          AppKeys.orderHistory.tr,
          style: AppFonts.heading2,
        ),
        leading: AppBarBackButton(),
      ),
      body: Obx(() => orderController.completedOrders.isEmpty &&
              orderController.comingOrders.isEmpty &&
              orderController.canceledOrders.isEmpty
          ? HistoryEmptyBody()
          : Column(
              children: [
                SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: TabBar(
                    controller: tabController,
                    labelStyle: TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w500),
                    indicatorColor: AppColors.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                    tabs: [
                      Text(AppKeys.coming.tr),
                      Text(AppKeys.completed.tr),
                      Text(AppKeys.cancelled.tr),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      OrdersList(status: OrderStatus.coming),
                      OrdersList(status: OrderStatus.completed),
                      OrdersList(status: OrderStatus.canceled),
                    ],
                  ),
                )
              ],
            )),
    );
  }
}
