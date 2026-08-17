import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../data/shared/auth_session.dart';
import '../../../utils/db_helper.dart';

class SplashController extends GetxController {
  bool _isPreparing = false;

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = Get.context;
      if (context != null) {
        _prepareOnboarding(context);
      }
    });
  }

  Future<void> _prepareOnboarding(BuildContext context) async {
    if (_isPreparing) return;
    _isPreparing = true;

    final minimumSplashTime = Future<void>.delayed(const Duration(seconds: 3));
    await minimumSplashTime;

    if (!isClosed) {
      final isLoggedIn =
          DbHelper().getIsLoggedIn() &&
          AuthSession.instance.user != null &&
          AuthSession.instance.token?.isNotEmpty == true;
      Get.offAllNamed<void>(
        isLoggedIn ? AppRoutes.dashboard : AppRoutes.selectLanguage,
      );
    }
  }
}
