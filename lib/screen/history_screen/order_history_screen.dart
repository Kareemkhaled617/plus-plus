import 'package:flutter/material.dart';
import 'package:plus/components/app_bar_back_button.dart';
import 'package:plus/generated/assets.dart';
import 'package:plus/screen/history_screen/widget/history_empty_body.dart';
import 'package:plus/utils/app_fonts.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> orders = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order History",
          style: AppFonts.heading3,
        ),
        leading: AppBarBackButton(),
      ),
      body: orders.isEmpty ? HistoryEmptyBody() : SizedBox(),
    );
  }
}
