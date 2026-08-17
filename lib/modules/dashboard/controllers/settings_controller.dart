import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../data/models/cms_model.dart';
import '../../../data/network/settings_api_provider.dart';
import '../../../data/shared/auth_session.dart';
import '../../../utils/utils.dart';

class SettingsController extends GetxController {
  SettingsController(this._apiProvider);

  final SettingsApiProvider _apiProvider;
  final Rxn<CmsModel> cms = Rxn<CmsModel>();

  Future<void> getCms(String type) async {
    cms.value = null;
    final response = await _apiProvider.getCms(type);
    if (response.success && response.body != null) {
      cms.value = response.body;
      return;
    }

    Utils.showSnackBar(
      response.message ?? 'Unable to load this page. Please try again.',
    );
  }

  Future<void> logoutApi() async {
    Get.back<void>();
    await Future<void>.delayed(Duration.zero);

    final response = await _apiProvider.logout();
    if (response.success) {
      await AuthSession.instance.clear();
      Get.offAllNamed<void>(AppRoutes.login);
      return;
    }

    Utils.showSnackBar(
      response.message ?? 'Unable to logout. Please try again.',
    );
  }
}
