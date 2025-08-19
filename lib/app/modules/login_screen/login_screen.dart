import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/login_screen/widgets/login_subtitle_widget.dart';
import 'package:plus/app/modules/login_screen/widgets/login_title_widget.dart';
import 'package:plus/app/modules/login_screen/widgets/phone_input_widget.dart';
import 'package:plus/app/modules/login_screen/widgets/submit_button_widget.dart';
import 'package:plus/app/modules/login_screen/widgets/terms_conditions_widget.dart';

import 'controller/auth_controller.dart';
import 'widgets/login_logo_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              const LoginLogoWidget(),
              const LoginTitleWidget(),
              const LoginSubtitleWidget(),
              PhoneInputWidget(
                authController: authController,
              ),
              const SizedBox(height: 20),
              SubmitButtonWidget(
                  authController: authController,
                  phoneController: authController.phoneController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const TermsAndConditionsWidget(),
    );
  }
}
