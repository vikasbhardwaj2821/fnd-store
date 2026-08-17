import 'package:get/get.dart';

import '../../../data/network/base_client.dart';
import '../../../data/network/settings_api_provider.dart';
import '../../../data/shared/api_helper.dart';
import '../../../data/shared/auth_session.dart';
import '../../dashboard/controllers/settings_controller.dart';

class CmsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<BaseClient>()) {
      Get.lazyPut<BaseClient>(
        () => BaseClient(
          accessTokenProvider: () async => AuthSession.instance.token,
        ),
      );
    }
    if (!Get.isRegistered<ApiHelper>()) {
      Get.lazyPut<ApiHelper>(() => ApiHelper(Get.find<BaseClient>()));
    }
    if (!Get.isRegistered<SettingsApiProvider>()) {
      Get.lazyPut<SettingsApiProvider>(
        () => SettingsApiProvider(Get.find<ApiHelper>()),
      );
    }
    if (!Get.isRegistered<SettingsController>()) {
      Get.lazyPut<SettingsController>(
        () => SettingsController(Get.find<SettingsApiProvider>()),
      );
    }
  }
}
