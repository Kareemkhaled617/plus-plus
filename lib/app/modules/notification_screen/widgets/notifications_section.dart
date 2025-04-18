import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../controller/notification_controller.dart';

class NotificationHeaderSection extends StatelessWidget {
  const NotificationHeaderSection({super.key, this.dataTime});

  final String? dataTime;

  @override
  Widget build(BuildContext context) {
    final NotificationController controller =
        Get.find<NotificationController>();
    return InkWell(
      onTap: () async {
        await controller.markAllNotificationsAsRead();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 16.0, top: 8, right: 20, left: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dataTime ?? "Today",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppFonts.heading3
                  .copyWith(color: AppColors.primary, fontSize: 14),
            ),
            Text(
              AppKeys.markAllAsRead.tr,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppFonts.heading3.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
