import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/modules/order_history_screen/widget/history_empty_body.dart';
import 'package:plus/app/modules/order_history_screen/widget/orders_list.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';


class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  final List<String> orders = ["Order1", "Order2", "Order3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          AppKeys.orderHistory.tr,
          style: AppFonts.heading3,
        ),
        leading: AppBarBackButton(),
      ),
      body: orders.isEmpty
          ? HistoryEmptyBody()
          : Column(
              children: [
                SizedBox(
                  height: 16,
                ),
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
                    children: [
                      OrdersList(),
                      OrdersList(),
                      OrdersList(),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
