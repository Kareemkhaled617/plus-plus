import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/service/localization_service.dart';
import '../../../core/storage/secure_storage_helper.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'en'.obs; // Default: English

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  /// **Load saved language from Secure Storage**
  Future<void> loadSavedLanguage() async {
    String? savedLang = await SecureStorageHelper().getData("language");
    if (savedLang != null) {
      selectedLanguage.value = savedLang;
      LocalizationService.changeLocale(savedLang);
    }
  }

  /// **Change language and store it securely**
  Future<void> changeLanguage(String lang) async {
    selectedLanguage.value = lang;
    await SecureStorageHelper().saveData("language", lang);
    LocalizationService.changeLocale(lang);
    Get.back(); // Close BottomSheet
  }
}
