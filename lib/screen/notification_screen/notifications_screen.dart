import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/components/app_bar_back_button.dart';
import 'package:plus/screen/notification_screen//widgets/notifications_list_item.dart';
import 'package:plus/screen/notification_screen//widgets/notifications_section.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';
import 'package:plus/utils/app_keys.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        "title": "New Message",
        "body": "You have received a new message.",
        "time": "5 min ago",
        "date": "Today"
      },
      {
        "title": "Order Update",
        "body": "Your order #1234 has been shipped.",
        "time": "1 hr ago",
        "date": "Today"
      },
      {
        "title": "Promotion",
        "body": "Get 20% off on your next purchase!",
        "time": "Yesterday",
        "date": "Yesterday"
      },
      {
        "title": "Reminder",
        "body": "Your appointment is tomorrow at 10 AM.",
        "time": "2 days ago",
        "date": "2 Days Ago"
      },
      {
        "title": "System Update",
        "body": "New security update available.",
        "time": "3 days ago",
        "date": "3 Days Ago"
      },
    ];
    // **Group notifications by date**
    Map<String, List<Map<String, String>>> groupedNotifications = {};
    for (var notification in notifications) {
      String date = notification["date"]!;
      if (!groupedNotifications.containsKey(date)) {
        groupedNotifications[date] = [];
      }
      groupedNotifications[date]!.add(notification);
    }

    // **Flattened list to include headers & items**
    List<dynamic> notificationItems = [];
    groupedNotifications.forEach((date, items) {
      notificationItems.add(date); // Add date as a header
      notificationItems.addAll(items); // Add notifications under that date
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppKeys.notification.tr,
          style: AppFonts.heading3,
        ),
        leading: AppBarBackButton(),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                color: AppColors.deepRed,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              "1 ${AppKeys.newText.tr}",
              style: AppFonts.bodyText.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: ListView.builder(
          itemCount: notificationItems.length,
          itemBuilder: (context, index) {
            var item = notificationItems[index];
            if (item is String) {
              return NotificationHeaderSection(dataTime: item);
            } else {
              // Render Notification Item
              return NotificationListItem(
                title: item['title']!,
                body: item['body']!,
                time: item['time']!,
              );
            }
          },
        ),
      ),
    );
  }
}
