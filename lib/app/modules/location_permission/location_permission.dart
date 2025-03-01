import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';

import '../../../generated/assets.dart';
import 'controller/location_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_sizes.dart';
import '../../core/widgets/custom_button.dart';


class LocationScreen extends StatelessWidget {
  final LocationController _locationController = Get.put(LocationController());

  LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(AppSizes.paddingMedium(context)),
        child: Obx(() {
          if (_locationController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!_locationController.isLocationEnabled.value &&
              _locationController.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 60),
                  SizedBox(height: AppSizes.paddingSmall(context)),
                  Text(
                    AppKeys.sorry.tr,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: AppSizes.paddingSmall(context)),
                  Text(
                    _locationController.errorMessage.value.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          }

          if (_locationController.isLocationEnabled.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.imagesLocationEnabled, height: 200),
                  SizedBox(height: AppSizes.paddingMedium(context)),
                  Text(
                    AppKeys.locatingLocation.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset( Assets.imagesLocationDisabled),
                SizedBox(height: AppSizes.paddingMedium(context)),
                Text(
                  "Enable Location Services".tr,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSizes.paddingSmall(context)),
                Text(
                  "Your location services are switched off. Please enable location to help us serve better."
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: AppSizes.paddingLarge(context)),
                CustomButton(
                  text: "Allow Location".tr,
                  onPressed: () =>
                      _locationController.checkLocationPermission(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
