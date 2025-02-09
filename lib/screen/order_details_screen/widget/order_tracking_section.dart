import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';

import '../../../utils/app_keys.dart';

class OrderTrackingSection extends StatefulWidget {
  const OrderTrackingSection({super.key});

  @override
  State<OrderTrackingSection> createState() => _OrderTrackingSectionState();
}

class _OrderTrackingSectionState extends State<OrderTrackingSection> {
  int currentStep = 0;

  // Index for the active step (0 = Received)
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shipped From Text
          Text(
            "${AppKeys.shippedFrom.tr} : Al-Liwaa store",
            style: AppFonts.heading3.copyWith(fontSize: 12),
          ),
          SizedBox(height: 20),

          // Package Image
          Center(
            child: Image.asset(
              Assets.imagesOrderTracking, // Replace with actual asset image
              width: 180,
            ),
          ),
          SizedBox(height: 10),

          // Delivery Expectation Text
          Center(
            child: Text(
              "${AppKeys.deliveryExpected.tr} 24 ${AppKeys.hours.tr}",
              style: AppFonts.bodyText
                  .copyWith(color: AppColors.primary, fontSize: 14),
            ),
          ),
          SizedBox(height: 20),

          // Order Tracking Progress Indicator
          Stepper(
            currentStep: currentStep,
            type: StepperType.vertical,
            physics: NeverScrollableScrollPhysics(),
            controlsBuilder: (context, details) => Container(),
            stepIconBuilder: (stepIndex, stepState) => SizedBox(
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
              ),
            ),
            onStepTapped: (value) {
              setState(() {
                currentStep = value;
              });
            },
            steps: [
              _buildStep(AppKeys.received.tr, 0, currentStep),
              _buildStep(AppKeys.preparing.tr, 1, currentStep),
              _buildStep(AppKeys.shipped.tr, 2, currentStep),
              _buildStep(AppKeys.delivered.tr, 3, currentStep),
            ],
          ),

          SizedBox(height: 20),

          // Cancel Order Button
          SizedBox(
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
                // Handle cancel order action
              },
              child: Text(
                AppKeys.cancelOrder.tr,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
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
}
