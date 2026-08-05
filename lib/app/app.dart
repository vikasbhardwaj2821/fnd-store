import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_strings.dart';
import '../utils/app_translations.dart';
import '../utils/common/app_colors.dart';
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
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 180),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        final bottomSafeInset = math.max(
          mediaQuery.padding.bottom,
          math.max(
            mediaQuery.viewPadding.bottom,
            mediaQuery.systemGestureInsets.bottom,
          ),
        );
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.noScaling,
            padding: mediaQuery.padding.copyWith(bottom: bottomSafeInset),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'PlusJakartaSans',
        visualDensity: VisualDensity.standard,
        scaffoldBackgroundColor: AppColors.pageBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.pageBackground,
        ),
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
