import 'package:get/get.dart';

import '../../../data/network/google_places_service.dart';
import '../../../data/network/auth_api_provider.dart';
import '../../../data/network/settings_api_provider.dart';
import '../../../data/network/base_client.dart';
import '../../../data/shared/api_helper.dart';
import '../../../data/shared/auth_session.dart';
import '../controllers/create_request_controller.dart';

class CreateRequestBinding extends Bindings {
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
    if (!Get.isRegistered<AuthApiProvider>()) {
      Get.lazyPut<AuthApiProvider>(
        () => AuthApiProvider(Get.find<ApiHelper>()),
      );
    }
    if (!Get.isRegistered<SettingsApiProvider>()) {
      Get.lazyPut<SettingsApiProvider>(
        () => SettingsApiProvider(Get.find<ApiHelper>()),
      );
    }
    Get.lazyPut<GooglePlacesService>(GooglePlacesService.new);
    Get.lazyPut<CreateRequestController>(
      () => CreateRequestController(
        Get.find<AuthApiProvider>(),
        Get.find<SettingsApiProvider>(),
        Get.find<GooglePlacesService>(),
      ),
    );
  }
}
