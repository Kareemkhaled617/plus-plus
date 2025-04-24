import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../core/widgets/app_bar_back_button.dart';
import '../../core/widgets/custom_button.dart';
import 'controller/change_phone_controller.dart';

class ChangePhoneScreen extends StatelessWidget {
  const ChangePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangePhoneController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: AppBarBackButton(),
        backgroundColor: AppColors.white,
        title: Text(AppKeys.account.tr, style: AppFonts.heading1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppKeys.phoneNumber.tr,
                  style: AppFonts.heading2.copyWith(fontSize: 14)),
              const SizedBox(height: 12),
              IntlPhoneField(
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: Icon(Icons.edit_document, color: AppColors.red),
                  fillColor: Colors.blue.shade50.withOpacity(.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                initialCountryCode: 'EG',
                onChanged: (phone) {
                  controller.setPhoneNumber(phone.completeNumber);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .3),
              Align(
                alignment: Alignment.center,
                child: Obx(() {
                  return CustomButton(
                    text: AppKeys.save.tr,
                    isEnabled: !controller.isLoading.value,
                    onPressed: controller.updatePhone,
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
