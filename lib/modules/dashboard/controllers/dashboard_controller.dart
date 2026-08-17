import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../data/network/api_constant.dart';
import '../../../data/network/settings_api_provider.dart';
import '../../../data/shared/auth_session.dart';

class DashboardController extends GetxController {
  DashboardController(this._apiProvider);

  final SettingsApiProvider _apiProvider;
  final currentIndex = 0.obs;
  final hasCreatedRequest = false.obs;
  final Rxn<UserModel> user = Rxn<UserModel>(AuthSession.instance.user);

  String get profileImageUrl {
    final path = user.value?.profilePicture;
    return path == null || path.isEmpty ? '' : ApiConstants.mediaUrl(path);
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    hasCreatedRequest.value =
        arguments is Map && arguments['hasCreatedRequest'] == true;
    getProfile();
  }

  Future<void> getProfile() async {
    final response = await _apiProvider.getProfile();
    if (!response.success || response.body == null) return;
    final refreshedUser = UserModel.fromJson({
      ...response.body!.toJson(),
      'token': AuthSession.instance.token,
    });
    user.value = refreshedUser;
    await AuthSession.instance.setUser(refreshedUser);
  }

  void changeTab(int index) {
    if (index != 2) currentIndex.value = index;
  }
}
