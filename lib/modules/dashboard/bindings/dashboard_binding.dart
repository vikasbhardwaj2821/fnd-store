import 'package:get/get.dart';

import '../../../data/network/base_client.dart';
import '../../../data/network/bookings_api_provider.dart';
import '../../../data/network/home_api_provider.dart';
import '../../../data/network/settings_api_provider.dart';
import '../../../data/shared/api_helper.dart';
import '../../../data/shared/auth_session.dart';
import '../../bookings/controllers/bookings_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/settings_controller.dart';

class DashboardBinding extends Bindings {
  static SettingsController ensureSettingsDependencies() {
    if (!Get.isRegistered<BaseClient>()) {
      Get.put<BaseClient>(
        BaseClient(accessTokenProvider: () async => AuthSession.instance.token),
      );
    }
    if (!Get.isRegistered<ApiHelper>()) {
      Get.put<ApiHelper>(ApiHelper(Get.find<BaseClient>()));
    }
    if (!Get.isRegistered<SettingsApiProvider>()) {
      Get.put<SettingsApiProvider>(SettingsApiProvider(Get.find<ApiHelper>()));
    }
    if (!Get.isRegistered<HomeApiProvider>()) {
      Get.put<HomeApiProvider>(HomeApiProvider(Get.find<ApiHelper>()));
    }
    if (!Get.isRegistered<BookingsApiProvider>()) {
      Get.put<BookingsApiProvider>(
        BookingsApiProvider(Get.find<ApiHelper>()),
      );
    }
    if (!Get.isRegistered<SettingsController>()) {
      Get.put<SettingsController>(
        SettingsController(Get.find<SettingsApiProvider>()),
      );
    }
    return Get.find<SettingsController>();
  }

  @override
  void dependencies() {
    ensureSettingsDependencies();
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        Get.find<SettingsApiProvider>(),
        Get.find<HomeApiProvider>(),
      ),
    );
    Get.lazyPut<BookingsController>(
      () => BookingsController(Get.find<BookingsApiProvider>()),
    );
  }
}
