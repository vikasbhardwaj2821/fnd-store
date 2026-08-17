import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../data/network/auth_api_provider.dart';
import '../../../data/validators/validator.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/common/camera_helper.dart';
import '../../../utils/utils.dart';

class CompleteProfileController extends GetxController
    implements CameraOnCompleteListener {
  CompleteProfileController(this._apiProvider) {
    cameraHelper = CameraHelper(this);
  }

  final AuthApiProvider _apiProvider;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final Rxn<File> profileImage = Rxn<File>();
  final RxBool acceptedTerms = false.obs;
  final Rx<Country> selectedCountry = allCountries
      .firstWhere((country) => country.code == 'AE')
      .obs;

  void openPhotoPicker(BuildContext context) {
    cameraHelper.openImagePicker();
  }

  late final CameraHelper cameraHelper;

  @override
  void onSuccessFile(String file, String fileType) {
    if (fileType == 'image') {
      profileImage.value = File(file);
      debugPrint('📸 Image selected path: $file');
    }
  }

  void toggleTerms(bool? value) {
    acceptedTerms.value = value ?? false;
  }

  void selectCountry(Country country) {
    selectedCountry.value = country;
    phoneController.clear();
  }

  Future<void> continueToStore() async {
    Utils.hideKeyboard(Get.context!);

    final isValid = Validator.validateCompleteProfile(
      firstName: firstNameController,
      lastName: lastNameController,
      email: emailController,
      phone: phoneController,
      country: selectedCountry.value,
      acceptedTerms: acceptedTerms.value,
    );
    if (!isValid) return;

    await signupApi();
  }

  Future<void> signupApi() async {
    final body = <String, dynamic>{
      'mobile_number': phoneController.text.trim(),
      'country_code': '+${selectedCountry.value.dialCode}',
      'role': 2,
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'email': emailController.text.trim(),
    };

    final imagePath = profileImage.value?.path ?? '';
    if (imagePath.isNotEmpty) {
      body['profilePicture'] = imagePath.split('/').last;
    }

    final response = await _apiProvider.signup(body);
    if (response.success && response.body != null) {
      final user = response.body!;
      Get.toNamed<void>(
        AppRoutes.verification,
        arguments: {
          'flow': 'signup',
          'user': user,
          'mobile_number': user.phoneNumber ?? phoneController.text.trim(),
          'country_code': user.countryCode,
          'otp': user.otp,
        },
      );
      return;
    }

    Utils.showSnackBar(
      response.message ?? 'Unable to create account. Please try again.',
    );
  }

  void openSignIn() {
    Get.toNamed<void>(AppRoutes.login);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
