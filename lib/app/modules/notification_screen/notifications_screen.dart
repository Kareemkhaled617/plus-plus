import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/core/widgets/loader.dart';
import 'package:plus/app/modules/notification_screen/widgets/no_notification.dart';
import 'package:plus/app/modules/notification_screen/widgets/notifications_list_item.dart';
import 'package:plus/app/modules/notification_screen/widgets/notifications_section.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../domain/entities/notification_entity.dart';
import 'controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller =
        Get.find<NotificationController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AppKeys.notification.tr,
          style: AppFonts.heading3,
        ),
        leading: const AppBarBackButton(),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                color: AppColors.deepRed,
                borderRadius: BorderRadius.circular(4)),
            child: Obx(() {
              int unreadCount =
                  controller.notifications.where((noti) => !noti.readed).length;
              return Text(
                "$unreadCount  ${AppKeys.newText.tr}",
                style: AppFonts.bodyText.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              );
            }),
          ),
          const SizedBox(width: 8),
        ],
        flexibleSpace: Container(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: AppLoader());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.notifications.isEmpty) {
          return NoFoundNotificationScreen();
        } else {
          final groupedNotifications =
              groupNotificationsByDate(controller.notifications);
          final sortedDates = groupedNotifications.keys.toList()
            ..sort((a, b) => b.compareTo(a)); // Sort dates in descending order

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: ListView.builder(
              itemCount: sortedDates.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                String date = sortedDates[index];
                List<NotificationEntity> notificationsForDate =
                    groupedNotifications[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NotificationHeaderSection(dataTime: date),
                    const SizedBox(height: 8),
                    ...notificationsForDate.map(
                      (notification) => Dismissible(
                        key: Key(notification.id),
                        background: Container(
                          color: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerLeft,
                          child: const Icon(Icons.notifications,
                              color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            // controller.markNotificationAsRead(notification.id);
                          } else if (direction == DismissDirection.endToStart) {
                            controller.deleteNotification(notification.id);
                          }
                        },
                        child: NotificationListItem(
                          title: notification.title,
                          body: notification.body,
                          time: notification.date,
                          isRead: notification.readed,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          );
        }
      }),
    );
  }
}

/// Function to group notifications by date
Map<String, List<NotificationEntity>> groupNotificationsByDate(
    List<NotificationEntity> notifications) {
  Map<String, List<NotificationEntity>> groupedNotifications = {};

  for (var notification in notifications) {
    if (!groupedNotifications.containsKey(notification.date)) {
      groupedNotifications[notification.date] = [];
    }
    groupedNotifications[notification.date]!.add(notification);
  }

  return groupedNotifications;
}
