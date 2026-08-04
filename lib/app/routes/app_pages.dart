import 'package:get/get.dart';

import '../../modules/complete_profile/bindings/complete_profile_binding.dart';
import '../../modules/complete_profile/views/complete_profile_view.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/login/bindings/login_binding.dart';
import '../../modules/login/views/login_view.dart';
import '../../modules/onboarding/bindings/onboarding_binding.dart';
import '../../modules/onboarding/views/onboarding_view.dart';
import '../../modules/select_language/bindings/select_language_binding.dart';
import '../../modules/select_language/views/select_language_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';
import '../../modules/verification/bindings/verification_binding.dart';
import '../../modules/verification/views/verification_view.dart';
import 'app_routes.dart';

abstract final class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage<void>(
      name: AppRoutes.splash,
      page: SplashView.new,
      binding: SplashBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.selectLanguage,
      page: SelectLanguageView.new,
      binding: SelectLanguageBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.completeProfile,
      page: CompleteProfileView.new,
      binding: CompleteProfileBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.login,
      page: LoginView.new,
      binding: LoginBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.verification,
      page: VerificationView.new,
      binding: VerificationBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.onboarding,
      page: OnboardingView.new,
      binding: OnboardingBinding(),
    ),
    GetPage<void>(name: AppRoutes.home, page: HomeView.new),
  ];
}
