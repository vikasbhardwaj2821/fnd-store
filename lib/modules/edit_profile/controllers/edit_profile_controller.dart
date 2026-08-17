import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/dashboard/controllers/dashboard_controller.dart';
import '../../../data/network/auth_api_provider.dart';
import '../../../data/shared/auth_session.dart';
import '../../../data/validators/validator.dart';
import '../../../utils/common/camera_helper.dart';
import '../../../data/network/api_constant.dart';
import '../../../utils/utils.dart';

class EditProfileController extends GetxController
    implements CameraOnCompleteListener {
  EditProfileController(this._apiProvider) {
    cameraHelper = CameraHelper(this);
  }

  final AuthApiProvider _apiProvider;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final Rxn<File> profileImage = Rxn<File>();

  late final CameraHelper cameraHelper;

  String get existingProfileImageUrl {
    final path = AuthSession.instance.user?.profilePicture;
    return path == null || path.isEmpty ? '' : ApiConstants.mediaUrl(path);
  }

  @override
  void onInit() {
    super.onInit();
    final user = AuthSession.instance.user;
    firstNameController.text = user?.firstName ?? '';
    lastNameController.text = user?.lastName ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = [
      user?.countryCode,
      user?.phoneNumber,
    ].whereType<String>().join();
  }

  Future<void> changeProfilePhoto() async {
    cameraHelper.openImagePicker();
  }

  @override
  void onSuccessFile(String file, String fileType) {
    if (fileType == 'image') {
      profileImage.value = File(file);
      debugPrint('📸 Image selected path: $file');
    }
  }

  Future<void> saveChanges() async {
    Utils.hideKeyboard(Get.context!);

    final isValid = Validator.validateUpdateProfile(
      firstName: firstNameController,
      lastName: lastNameController,
      email: emailController,
    );
    if (!isValid) return;

    final body = <String, dynamic>{
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'email': emailController.text.trim(),
      'profile_step': 1,
      'role': AuthSession.instance.user?.role ?? 2,
    };

    final imagePath = profileImage.value?.path ?? '';
    if (imagePath.isNotEmpty) {
      body['profilePicture'] = imagePath.split('/').last;
    }

    final response = await _apiProvider.completeProfile(body);
    if (!response.success || response.body == null) {
      Utils.showSnackBar(
        response.message ?? 'Unable to update profile. Please try again.',
      );
      return;
    }

    await AuthSession.instance.setUser(
      response.body!.copyWith(
        token: AuthSession.instance.token ?? response.body!.token,
      ),
    );
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().user.value = AuthSession.instance.user;
    }
    Get.back(result: true);
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
