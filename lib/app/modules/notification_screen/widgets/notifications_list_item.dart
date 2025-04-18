import 'package:flutter/material.dart';

import '../../../core/theme/app_fonts.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    super.key,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });

  final String title;
  final String body;
  final String time;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isRead ? Colors.grey.withOpacity(.4) : Colors.white,
      ),
      child: ListTile(
        leading: Icon(
          Icons.production_quantity_limits,
          color: Colors.deepOrange,
          size: 32,
        ),
        title: Text(
          title,
          style: AppFonts.bodyText,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          body,
          style: AppFonts.hintText.copyWith(fontSize: 14),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: Text(
          time,
          style: AppFonts.hintText.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
