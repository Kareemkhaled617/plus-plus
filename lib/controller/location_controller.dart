import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  var isLocationEnabled = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> checkLocationPermission() async {
    isLoading.value = true;
    try {
      var status = await Permission.location.status;
      if (status.isGranted) {
        isLocationEnabled.value = true;
      } else if (status.isDenied) {
        var result = await Permission.location.request();
        if (result.isGranted) {
          isLocationEnabled.value = true;
        } else {
          errorMessage.value = 'You Should Allow your location first.';
        }
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
        errorMessage.value = 'Please enable location from app settings.';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred while accessing location.';
    } finally {
      isLoading.value = false;
    }
  }
}
