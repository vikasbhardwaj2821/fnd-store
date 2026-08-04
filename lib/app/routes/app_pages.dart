import 'package:get/get.dart';

import '../../modules/complete_profile/bindings/complete_profile_binding.dart';
import '../../modules/complete_profile/views/complete_profile_view.dart';
import '../../modules/bookings/views/booking_details_view.dart';
import '../../modules/bookings/views/track_delivery_view.dart';
import '../../modules/bookings/views/rate_delivery_view.dart';
import '../../modules/cms/views/cms_view.dart';
import '../../modules/contact_us/bindings/contact_us_binding.dart';
import '../../modules/contact_us/views/contact_us_view.dart';
import '../../modules/create_request/bindings/create_request_binding.dart';
import '../../modules/create_request/views/create_request_view.dart';
import '../../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../../modules/edit_profile/views/edit_profile_view.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/login/bindings/login_binding.dart';
import '../../modules/login/views/login_view.dart';
import '../../modules/notifications/bindings/notifications_binding.dart';
import '../../modules/notifications/views/notifications_view.dart';
import '../../modules/onboarding/bindings/onboarding_binding.dart';
import '../../modules/onboarding/views/onboarding_view.dart';
import '../../modules/select_language/bindings/select_language_binding.dart';
import '../../modules/select_language/views/change_language_view.dart';
import '../../modules/select_language/views/select_language_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';
import '../../modules/store_details/bindings/store_details_binding.dart';
import '../../modules/store_details/views/store_details_view.dart';
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
      name: AppRoutes.createRequest,
      page: CreateRequestView.new,
      binding: CreateRequestBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.editProfile,
      page: EditProfileView.new,
      binding: EditProfileBinding(),
    ),
    GetPage<void>(name: AppRoutes.privacyPolicy, page: CmsView.new),
    GetPage<void>(name: AppRoutes.termsAndConditions, page: CmsView.new),
    GetPage<void>(
      name: AppRoutes.contactUs,
      page: ContactUsView.new,
      binding: ContactUsBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.changeLanguage,
      page: ChangeLanguageView.new,
      binding: SelectLanguageBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.notifications,
      page: NotificationsView.new,
      binding: NotificationsBinding(),
    ),
    GetPage<void>(name: AppRoutes.bookingDetails, page: BookingDetailsView.new),
    GetPage<void>(name: AppRoutes.trackDelivery, page: TrackDeliveryView.new),
    GetPage<void>(name: AppRoutes.rateDelivery, page: RateDeliveryView.new),
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
      name: AppRoutes.storeDetails,
      page: StoreDetailsView.new,
      binding: StoreDetailsBinding(),
    ),
    GetPage<void>(
      name: AppRoutes.onboarding,
      page: OnboardingView.new,
      binding: OnboardingBinding(),
    ),
    GetPage<void>(name: AppRoutes.dashboard, page: HomeView.new),
  ];
}
