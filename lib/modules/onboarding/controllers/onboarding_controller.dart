import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';

class OnboardingPageData {
  const OnboardingPageData({required this.image});

  final String image;

  ImageProvider<Object> provider(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cacheWidth = (mediaQuery.size.width * mediaQuery.devicePixelRatio)
        .round();

    return ResizeImage.resizeIfNeeded(cacheWidth, null, AssetImage(image));
  }
}

class OnboardingController extends GetxController {
  static const List<OnboardingPageData> pages = [
    OnboardingPageData(image: 'assets/images/onboardingScreenOne.jpg'),
    OnboardingPageData(image: 'assets/images/onboardingScreenSecond.jpg'),
    OnboardingPageData(image: 'assets/images/onboardingScreenThird.jpg'),
  ];

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  bool get isFirstPage => currentPage.value == 0;
  bool get isLastPage => currentPage.value == pages.length - 1;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void skipOnboarding() {
    Get.offNamed<void>(AppRoutes.selectLanguage);
  }

  Future<void> nextPage() async {
    if (isLastPage) {
      skipOnboarding();
      return;
    }

    await pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> previousPage() async {
    if (isFirstPage) return;

    await pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
