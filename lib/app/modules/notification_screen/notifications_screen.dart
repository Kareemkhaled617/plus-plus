import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/core/widgets/loader.dart';
import 'package:plus/app/modules/notification_screen/widgets/no_notification.dart';
import 'package:plus/app/modules/notification_screen/widgets/notifications_list_item.dart';
import 'package:plus/app/modules/notification_screen/widgets/notifications_section.dart';
import 'package:plus/generated/assets.dart';

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        centerTitle: false,
        leading: const AppBarBackButton(),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                AppKeys.notification.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.heading1.copyWith(fontSize: 20), // a bit bigger
              ),
            ),
            Image.asset(
              Assets.imagesNotiScreen,
              width: 130,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        // actions: [
        //   Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        //     margin: const EdgeInsets.only(right: 20),
        //     decoration: BoxDecoration(
        //         color: AppColors.deepRed,
        //         borderRadius: BorderRadius.circular(4)),
        //     child: Obx(() {
        //       int unreadCount =
        //           controller.notifications.where((noti) => !noti.readed).length;
        //       return Text(
        //         "$unreadCount  ${AppKeys.newText.tr}",
        //         style: AppFonts.bodyText.copyWith(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 16,
        //         ),
        //       );
        //     }),
        //   ),
        //   const SizedBox(width: 8),
        // ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFED1B24).withOpacity(.4),
                const Color(0x00FF6D6D).withOpacity(.1)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoader());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.notificationsBySection.isEmpty) {
          return NoFoundNotificationScreen();
        } else {
          final sections = controller.notificationsBySection.keys.toList();

          return ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              final notifications = controller.notificationsBySection[section]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotificationHeaderSection(dataTime: section),
                  ...notifications.map(
                    (notification) => NotificationListItem(
                      title: notification.title,
                      body: notification.body,
                      time: notification.date,
                      isRead: notification.readed,
                    ),
                  ),
                ],
              );
            },
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
