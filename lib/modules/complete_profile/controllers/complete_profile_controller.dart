import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/routes/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/utils.dart';

class CompleteProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final Rxn<File> profileImage = Rxn<File>();
  final RxBool acceptedTerms = false.obs;
  final Rx<Country> selectedCountry = allCountries
      .firstWhere((country) => country.code == 'AE')
      .obs;

  final ImagePicker _imagePicker = ImagePicker();

  void openPhotoPicker(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      isDismissible: true,
      bottomSheetColor: AppColors.white,
      actions: [
        BottomSheetAction(
          title: const Center(
            child: AppText(
              text: AppStrings.chooseFromLibrary,
              color: AppColors.primary,
              textSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: (_) {
            Get.back<void>();
            _pickImage(ImageSource.gallery);
          },
        ),
        BottomSheetAction(
          title: const Center(
            child: AppText(
              text: AppStrings.takePhoto,
              color: AppColors.primary,
              textSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: (_) {
            Get.back<void>();
            _pickImage(ImageSource.camera);
          },
        ),
      ],
      cancelAction: CancelAction(
        title: const AppText(
          text: AppStrings.cancel,
          color: AppColors.error,
          textSize: 16,
          fontWeight: FontWeight.w600,
        ),
        onPressed: (_) => Get.back<void>(),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1200,
    );

    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  void toggleTerms(bool? value) {
    acceptedTerms.value = value ?? false;
  }

  void selectCountry(Country country) {
    selectedCountry.value = country;
    phoneController.clear();
  }

  void continueToStore() {
    Utils.hideKeyboard(Get.context!);
    Get.offAllNamed<void>(AppRoutes.home);
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
