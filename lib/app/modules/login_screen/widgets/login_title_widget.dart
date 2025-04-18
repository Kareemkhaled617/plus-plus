import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';

class LoginTitleWidget extends StatelessWidget {
  const LoginTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppKeys.whatsYourNumber.tr,
      style: AppFonts.headline1,
    );
  }
}
