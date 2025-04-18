import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../domain/entities/order_entity.dart';
import '../controller/order_details_controller.dart';

class OrderTrackingSection extends StatefulWidget {
  const OrderTrackingSection({super.key, required this.orderEntity});

  final OrderEntity orderEntity;

  @override
  State<OrderTrackingSection> createState() => _OrderTrackingSectionState();
}

class _OrderTrackingSectionState extends State<OrderTrackingSection> {
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    currentStep = getCurrentStep(widget.orderEntity.status);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shipped From Text
          // Text(
          //   "${AppKeys.shippedFrom.tr} : Al-Liwaa store",
          //   style: AppFonts.heading2.copyWith(fontSize: 14),
          // ),
          // SizedBox(height: 20),
          //
          // // Package Image
          // Center(
          //   child: Image.asset(
          //     Assets.imagesOrderTracking, // Replace with actual asset image
          //     width: 180,
          //   ),
          // ),
          // SizedBox(height: 10),
          //
          // // Delivery Expectation Text
          // Center(
          //   child: Text(
          //     "${AppKeys.deliveryExpected.tr} 24 ${AppKeys.hours.tr}",
          //     style: AppFonts.bodyText
          //         .copyWith(color: AppColors.primary, fontSize: 14),
          //   ),
          // ),
          SizedBox(height: 20),

          // Order Tracking Progress Indicator
          widget.orderEntity.status == 'canceled'
              ? Container()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: AppColors.primary,
                            ),
                      ),
                      child: Stepper(
                        currentStep: currentStep,
                        type: StepperType.vertical,
                        physics: ClampingScrollPhysics(),
                        onStepTapped: (step) {},
                        controlsBuilder: (context, details) =>
                            SizedBox.shrink(),
                        steps: [
                          _buildStep(AppKeys.pending.tr, 0, currentStep),
                          _buildStep(AppKeys.received.tr, 1, currentStep),
                          _buildStep(AppKeys.preparing.tr, 2, currentStep),
                          _buildStep(AppKeys.shipped.tr, 3, currentStep),
                          _buildStep(AppKeys.delivered.tr, 4, currentStep),
                          _buildStep(AppKeys.completed.tr, 5, currentStep),
                        ],
                      ),
                    ),
                  ),
                ),

          SizedBox(height: 20),

          // Cancel Order Button
          (widget.orderEntity.status != 'completed' &&
                  widget.orderEntity.status != 'canceled')
              ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      controller.cancelOrder(widget.orderEntity.id);
                    },
                    child: Text(
                      AppKeys.cancelOrder.tr,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Step _buildStep(String title, int step, int currentStep) {
    return Step(
      title: Text(
        title,
        style: TextStyle(
          color: step == currentStep ? AppColors.primary : Colors.grey,
          fontWeight: step == currentStep ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      content: SizedBox.shrink(),
      stepStyle: StepStyle(
        color:
            step <= currentStep ? AppColors.primary : AppColors.greyWithShade,
      ),
      isActive: step <= currentStep,
    );
  }

  int getCurrentStep(String status) {
    switch (status) {
      case 'pending':
        return 0;
      case 'received':
        return 1;
      case 'preparing':
        return 2;
      case 'has_shipped':
        return 3;
      case 'delivered':
        return 4;
      case 'completed':
        return 5;
      default:
        return 0; // fallback if status is unknown
    }
  }
}
