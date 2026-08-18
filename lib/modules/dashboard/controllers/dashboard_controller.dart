import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/home_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/network/api_constant.dart';
import '../../../data/network/home_api_provider.dart';
import '../../../data/network/settings_api_provider.dart';
import '../../../data/shared/auth_session.dart';

class DashboardController extends GetxController {
  DashboardController(this._apiProvider, this._homeApiProvider);

  final SettingsApiProvider _apiProvider;
  final HomeApiProvider _homeApiProvider;
  final currentIndex = 0.obs;
  final hasCreatedRequest = false.obs;
  final isHomeLoading = true.obs;
  final Rxn<UserModel> user = Rxn<UserModel>(AuthSession.instance.user);
  final Rxn<HomeModel> homeData = Rxn<HomeModel>();

  bool get hasHomeItems {
    final data = homeData.value;
    if (data == null) return false;
    return data.todayBookings.isNotEmpty;
  }

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
    getHome();
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

  Future<void> getHome() async {
    isHomeLoading.value = true;
    final response = await _homeApiProvider.getHome();
    isHomeLoading.value = false;
    if (!response.success || response.body == null) return;
    debugPrint('HOME API RESPONSE: ${response.body}');
    homeData.value = HomeModel.fromJson(response.body!);
  }

  void changeTab(int index) {
    if (index != 2) currentIndex.value = index;
  }
}
