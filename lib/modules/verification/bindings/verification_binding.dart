import 'package:get/get.dart';

import '../../../data/network/auth_api_provider.dart';
import '../../../data/network/base_client.dart';
import '../../../data/shared/api_helper.dart';
import '../../../data/shared/auth_session.dart';
import '../controllers/verification_controller.dart';

class VerificationBinding extends Bindings {
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
    Get.lazyPut<VerificationController>(
      () => VerificationController(Get.find<AuthApiProvider>()),
    );
  }
}
