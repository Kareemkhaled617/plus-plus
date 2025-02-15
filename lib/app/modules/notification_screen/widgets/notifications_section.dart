import 'package:flutter/material.dart';


import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class NotificationHeaderSection extends StatelessWidget {
  const NotificationHeaderSection({super.key, this.dataTime});

  final String? dataTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dataTime ?? "Today",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppFonts.heading3.copyWith(color: AppColors.primary,fontSize: 14),
          ),
          InkWell(
            onTap: () {
              // Todo Call Api To mark all as Read
            },
            child: Text(
              "Mark all as read",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppFonts.heading3.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
