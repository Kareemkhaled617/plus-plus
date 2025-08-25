import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_fonts.dart';

class NoFoundNotificationScreen extends StatelessWidget {
  const NoFoundNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/no_notification.png')),
          SizedBox(height: 30,),
          Text(
            'No notifications available.'.tr,
            style: AppFonts.heading3.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
