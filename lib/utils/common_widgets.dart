import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonWidgets {
  /// Navigation with Fade Animation using GetX
  static void navigateWithFade(Widget destination) {
    Get.to(
      () => destination,
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }

  /// Navigation with Fade Animation using GetX
  static void navigateOffWithFade(Widget destination) {
    Get.off(
      () => destination,
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }

  /// Navigation with Slide Animation using GetX
  static void navigateWithSlide(Widget destination) {
    Get.to(
      () => destination,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
    );
  }

  /// Custom AlertDialog using GetX
  static void showCustomAlertDialog({
    required String title,
    required String message,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textCancel: "Cancel",
      textConfirm: "Confirm",
      onCancel: onCancel ?? () => Get.back(),
      onConfirm: onConfirm ?? () => Get.back(),
      confirmTextColor: Colors.white,
      barrierDismissible: false,
      buttonColor: Colors.blue,
    );
  }

  /// Custom Loading Indicator
  static void showLoading({String? message}) {
    Get.dialog(
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ]
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Hide Loading Indicator
  static void hideLoading() {
    if (Get.isDialogOpen == true) Get.back();
  }

  /// SnackBar with GetX
  static void showSnackBar(String title, String message,
      {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  /// Confirmation Dialog
  static void showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textCancel: "No",
      textConfirm: "Yes",
      onConfirm: onConfirm,
      confirmTextColor: Colors.white,
      barrierDismissible: false,
    );
  }
}
