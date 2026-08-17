import 'package:get/get.dart';

import '../../../data/network/auth_api_provider.dart';
import '../../../data/network/base_client.dart';
import '../../../data/shared/api_helper.dart';
import '../../../data/shared/auth_session.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseClient>(
      () => BaseClient(
        accessTokenProvider: () async => AuthSession.instance.token,
      ),
    );
    Get.lazyPut<ApiHelper>(() => ApiHelper(Get.find<BaseClient>()));
    Get.lazyPut<AuthApiProvider>(() => AuthApiProvider(Get.find<ApiHelper>()));
    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<AuthApiProvider>()),
    );
  }
}
