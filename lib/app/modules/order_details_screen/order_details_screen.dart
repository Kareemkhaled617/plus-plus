import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(AppKeys.orderDetails.tr, style: AppFonts.heading3.copyWith(fontSize: 17)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rewards Section
              RewardsSection(),
              SizedBox(height: 20),

              // General Info Section
              GeneralInfoSection(),
              SizedBox(height: 20),
          
              // Shipping Details Section
              ShippingDetailsSection(),
              SizedBox(height: 20),
          
              PaymentInfoSection(),
              SizedBox(
                height: 20,
              )
          ,
              OrderTrackingSection(),
            ],
          ),
        ),
      ),
    );
  }
}
