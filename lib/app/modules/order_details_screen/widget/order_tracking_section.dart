import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
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
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    activeStep = getCurrentStep(widget.orderEntity.status);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderDetailsController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (widget.orderEntity.status != 'canceled')
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: EasyStepper(
                activeStep: activeStep,
                lineStyle: const LineStyle(
                  lineLength: 60,
                  lineType: LineType.normal,
                  lineThickness: 5,
                  lineSpace: 1,
                  unreachedLineType: LineType.normal,
                ),
                stepShape: StepShape.circle,
                stepRadius: 30,
                internalPadding: 10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                borderThickness: 2,
                finishedStepBackgroundColor: AppColors.primary,
                finishedStepTextColor: AppColors.primary,
                finishedStepBorderColor: AppColors.primary,
                activeStepIconColor: AppColors.primary,
                steps: [
                  EasyStep(
                    icon: const Icon(CupertinoIcons.cart),
                    title: AppKeys.pending.tr,
                    lineText: AppKeys.pending.tr,
                  ),
                  EasyStep(
                    icon: const Icon(CupertinoIcons.cube_box),
                    title: AppKeys.received.tr,
                    lineText: AppKeys.orderReceived.tr,
                  ),
                  EasyStep(
                    icon: const Icon(CupertinoIcons.wrench),
                    title: AppKeys.preparing.tr,
                    lineText: AppKeys.preparingOrder.tr,
                  ),
                  EasyStep(
                    icon: const Icon(CupertinoIcons.car),
                    title: AppKeys.shipped.tr,
                    lineText: AppKeys.outForDelivery.tr,
                  ),
                  EasyStep(
                    icon: const Icon(CupertinoIcons.location_solid),
                    title: AppKeys.delivered.tr,
                    lineText: AppKeys.deliveredToYou.tr,
                  ),
                  EasyStep(
                    icon: const Icon(CupertinoIcons.checkmark_seal),
                    title: AppKeys.completed.tr,
                    lineText: AppKeys.orderCompleted.tr,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          if (widget.orderEntity.status != 'completed' &&
              widget.orderEntity.status != 'canceled')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.cancelOrder(widget.orderEntity.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  AppKeys.cancelOrder.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
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
        return 0;
    }
  }
}
