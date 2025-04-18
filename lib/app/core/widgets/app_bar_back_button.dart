import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:plus/app/core/theme/app_colors.dart';

import '../../../generated/assets.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Icon(
        Icons.arrow_back_ios_new,
        size: 20,
      ),
    );
  }
}
