import 'package:flutter/material.dart';

import '../../../core/theme/app_fonts.dart';


class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    super.key,
    required this.title,
    required this.body,
    required this.time,
  });

  final String title;
  final String body;
  final String time;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.production_quantity_limits,
        color: Colors.deepOrange,
        size: 32,
      ),
      title: Text(
        title ,
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
        time ,
        style: AppFonts.hintText.copyWith(fontSize: 12),
      ),
    );
  }
}
