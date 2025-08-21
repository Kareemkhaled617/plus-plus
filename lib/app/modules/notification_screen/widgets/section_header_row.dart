// lib/app/modules/notification_screen/widgets/section_header_row.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionHeaderRow extends StatelessWidget {
  final String title;
  final VoidCallback onMarkAll;
  const SectionHeaderRow({super.key, required this.title, required this.onMarkAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xffE53935),
              fontWeight: FontWeight.w700,
              letterSpacing: .5,
            )),
        const Spacer(),
        GestureDetector(
          onTap: onMarkAll,
          child:  Text(
            'Mark all as read'.tr,
            style: TextStyle(
              color: Color(0xff0D47A1),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
