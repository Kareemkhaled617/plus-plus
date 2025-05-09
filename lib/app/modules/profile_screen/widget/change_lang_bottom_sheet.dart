import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/modules/account_screen/controller/account_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../controller/language_controller.dart';

void showLanguageBottomSheet() {
  final LanguageController controller = Get.find<LanguageController>();
  final AccountController accountController = Get.find<AccountController>();

  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppKeys.selectTheLanguage.tr,
            style: AppFonts.heading2,
          ),
          SizedBox(height: 16),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Radio<String>(
                        value: 'en',
                        groupValue: controller.selectedLanguage.value,
                        onChanged: (value) async {
                          controller.changeLanguage(value!);
                          await accountController.changeLanguage('en');
                        },
                        activeColor: AppColors.primary,
                      ),
                      title: Text("English", style: AppFonts.bodyText),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Radio<String>(
                        value: 'ar',
                        groupValue: controller.selectedLanguage.value,
                        onChanged: (value) async {
                          controller.changeLanguage(value!);
                          await accountController.changeLanguage('ar');
                        },
                        activeColor: AppColors.primary,
                      ),
                      title: Text("العربية", style: AppFonts.bodyText),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Save".tr,
                style: AppFonts.bodyText.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
    isDismissible: true,
  );
}


