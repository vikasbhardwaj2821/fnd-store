import 'package:flutter/material.dart';

import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppText(
          text: AppStrings.appName,
          color: AppColors.black,
          textSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
