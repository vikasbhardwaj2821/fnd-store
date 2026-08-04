import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../onboarding/controllers/onboarding_controller.dart';

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

    await Future.wait<void>([
      Future<void>.delayed(const Duration(seconds: 3)),
      Future.wait<void>(
        OnboardingController.pages.map(
          (page) => precacheImage(page.provider(context), context),
        ),
      ),
    ]);

    if (!isClosed) {
      Get.offNamed<void>(AppRoutes.onboarding);
    }
  }
}
