import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_strings.dart';
import '../utils/app_translations.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class FndStoreApp extends StatelessWidget {
  const FndStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName.tr,
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      defaultTransition: Transition.cupertino,
      theme: ThemeData(useMaterial3: true, fontFamily: 'PlusJakartaSans'),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
