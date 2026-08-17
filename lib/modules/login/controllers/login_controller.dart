import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../data/network/auth_api_provider.dart';
import '../../../data/validators/validator.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/utils.dart';

class LoginController extends GetxController {
  LoginController(this._apiProvider);

  final AuthApiProvider _apiProvider;
  final phoneController = TextEditingController();
  final Rx<Country> selectedCountry = allCountries
      .firstWhere((country) => country.code == 'AE')
      .obs;

  void selectCountry(Country country) {
    selectedCountry.value = country;
    phoneController.clear();
  }

  Future<void> continueWithPhone() async {
    Utils.hideKeyboard(Get.context!);

    final isValid = Validator.validateLogin(
      phoneController: phoneController,
      selectedCountry: selectedCountry.value,
    );
    if (!isValid) return;

    await loginApi();
  }

  Future<void> loginApi() async {
    try {
      final response = await _apiProvider.login({
        'mobile_number': phoneController.text.trim(),
        'country_code': '+${selectedCountry.value.dialCode}',
        'role': 1,
      });

      if (response.success && response.body != null) {
        final user = response.body!;
        Get.toNamed<void>(
          AppRoutes.verification,
          arguments: {
            'user': user,
            'mobile_number': user.phoneNumber,
            'country_code': user.countryCode,
            'otp': user.otp,
            'profileStep': user.profileStep,
          },
        );
        return;
      }

      Utils.showSnackBar(
        response.message ?? 'Unable to send OTP. Please try again.',
      );
    } catch (_) {
      Utils.showSnackBar('Unable to send OTP. Please try again.');
    }
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
