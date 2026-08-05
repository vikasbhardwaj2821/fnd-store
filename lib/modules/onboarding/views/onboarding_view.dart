import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_text.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: controller.pageController,
            itemCount: OnboardingController.pages.length,
            onPageChanged: controller.onPageChanged,
            itemBuilder: (context, index) {
              return Image(
                image: OnboardingController.pages[index].provider(context),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              minimum: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: SizedBox(
                height: 210,
                child: Column(
                  children: [
                    const AppText(
                      text: AppStrings.onboardingWelcome,
                      textAlign: TextAlign.center,
                      color: AppColors.black,
                      textSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: AppText(
                        text: AppStrings.onboardingDescription,
                        textAlign: TextAlign.center,
                        color: AppColors.textSecondary,
                        textSize: 13,
                        fontWeight: FontWeight.w400,
                        lineHeight: 1.5,
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 110,
                            height: 45,
                            child: controller.isFirstPage
                                ? null
                                : AppButton(
                                    text: AppStrings.back,
                                    onTap: controller.previousPage,
                                    width: 110,
                                    height: 45,
                                    padding: EdgeInsets.zero,
                                    backgroundColor: AppColors.transparent,
                                    textColor: AppColors.textSecondary,
                                    textSize: 14,
                                    fontWeight: FontWeight.w400,
                                    showShadow: false,
                                  ),
                          ),
                          AppButton(
                            text: controller.isLastPage
                                ? AppStrings.getStarted
                                : AppStrings.next,
                            onTap: controller.nextPage,
                            width: controller.isLastPage ? 110 : 110,
                            height: 45,
                            borderRadius: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            backgroundColor: AppColors.primary,
                            textColor: AppColors.white,
                            textSize: 13,
                            fontWeight: FontWeight.w500,
                            showShadow: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
