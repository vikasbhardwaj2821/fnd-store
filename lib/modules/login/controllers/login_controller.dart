import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/utils.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final Rx<Country> selectedCountry = allCountries
      .firstWhere((country) => country.code == 'AE')
      .obs;

  void selectCountry(Country country) {
    selectedCountry.value = country;
    phoneController.clear();
  }

  void continueWithPhone() {
    Utils.hideKeyboard(Get.context!);
    Get.toNamed<void>(AppRoutes.verification);
  }

  void continueWithGoogle() {
    // Connect Google authentication here.
  }

  void continueWithApple() {
    // Connect Apple authentication here.
  }

  void openSignUp() {
    Get.offNamed<void>(AppRoutes.completeProfile);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
