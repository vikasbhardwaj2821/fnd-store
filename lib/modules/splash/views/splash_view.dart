import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/common/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  static const String backgroundAsset = 'assets/images/splashScreen.png';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SizedBox.expand(
        child: Image(image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
    );
  }
}
