import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../domain/usecases/get_notifications_usecase.dart';

class NotificationController extends GetxController {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationAsReadUseCase markNotificationAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase markAllNotificationsAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
  final DeleteAllNotificationsUseCase deleteAllNotificationsUseCase;

  NotificationController(
    this.getNotificationsUseCase,
    this.markNotificationAsReadUseCase,
    this.markAllNotificationsAsReadUseCase,
    this.deleteNotificationUseCase,
    this.deleteAllNotificationsUseCase,
  );

  var notifications = <NotificationEntity>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var notificationsBySection = <String, List<NotificationEntity>>{}.obs;

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  /// Fetch notifications from the API
  Future<void> fetchNotifications() async {
    isLoading.value = true;
    final result = await getNotificationsUseCase();

    result.fold(
          (failure) => errorMessage.value = failure.message,
          (data) {
        notificationsBySection.clear();
        for (var noti in data) {
          notificationsBySection.putIfAbsent(noti.section, () => []);
          notificationsBySection[noti.section]!.add(noti);
        }
      },
    );
    isLoading.value = false;
  }

  /// 🔹 **Mark Notification as Read Instantly & Update API**
  Future<void> markNotificationAsRead(String notificationId) async {
    // Update UI instantly
    notifications.value = notifications.map((noti) {
      if (noti.id == notificationId) {
        return noti;
      }
      return noti;
    }).toList();

    // API Call
    final result = await markNotificationAsReadUseCase(notificationId);
    result.fold(
      (failure) =>
          Get.snackbar('Error'.tr, failure.message, backgroundColor: Colors.red),
      (_) => print("Notification marked as read: $notificationId"),
    );
  }

  Future<void> markAllNotificationsAsRead() async {
    final Either<Failure, void> result =
        await markAllNotificationsAsReadUseCase();

    result.fold(
      (failure) => Get.snackbar("Error", failure.message),
      (_) {
        notifications.value =
            notifications.map((notification) => notification).toList();
      },
    );
  }

  /// 🔹 **Delete Notification Instantly & Update API**
  Future<void> deleteNotification(String notificationId) async {
    // Update UI instantly
    notifications.removeWhere((noti) => noti.id == notificationId);

    // API Call
    final result = await deleteNotificationUseCase(notificationId);
    result.fold(
      (failure) =>
          Get.snackbar('Error', failure.message, backgroundColor: Colors.red),
      (_) => Get.snackbar(
        'Success'.tr,
        'Notification deleted successfully.'.tr,
      ),
    );
  }
}
