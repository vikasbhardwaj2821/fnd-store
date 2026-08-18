import 'package:get/get.dart';

import '../../../data/network/base_client.dart';
import '../../../data/network/support_api_provider.dart';
import '../../../data/shared/api_helper.dart';
import '../../../data/shared/auth_session.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseClient>(
      () => BaseClient(
        accessTokenProvider: () async => AuthSession.instance.token,
      ),
    );
    Get.lazyPut<ApiHelper>(() => ApiHelper(Get.find<BaseClient>()));
    Get.lazyPut<SupportApiProvider>(
      () => SupportApiProvider(Get.find<ApiHelper>()),
    );
    Get.lazyPut<ContactUsController>(
      () => ContactUsController(Get.find<SupportApiProvider>()),
    );
  }
}
