import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';

enum AppLanguage { english, arabic }

class SelectLanguageController extends GetxController {
  final Rx<AppLanguage> selectedLanguage = AppLanguage.english.obs;

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value = Get.locale?.languageCode == 'ar'
        ? AppLanguage.arabic
        : AppLanguage.english;
  }

  void selectLanguage(AppLanguage language) {
    selectedLanguage.value = language;
  }

  Future<void> continueToOnboarding() async {
    final locale = selectedLanguage.value == AppLanguage.arabic
        ? const Locale('ar', 'AE')
        : const Locale('en', 'US');

    if (Get.locale != locale) {
      await Get.updateLocale(locale);
    }
    Get.offNamed<void>(AppRoutes.onboarding);
  }

  Future<void> saveAndGoBack() async {
    final locale = selectedLanguage.value == AppLanguage.arabic
        ? const Locale('ar', 'AE')
        : const Locale('en', 'US');
    if (Get.locale != locale) await Get.updateLocale(locale);
    Get.back<void>();
  }
}
