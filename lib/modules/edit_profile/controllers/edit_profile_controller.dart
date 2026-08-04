import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final firstNameController = TextEditingController(text: 'Mily');
  final lastNameController = TextEditingController(text: 'Deo');
  final emailController = TextEditingController(text: 'milydeo123@gmail.com');
  final phoneController = TextEditingController(text: '+11234567890');
  final Rxn<File> profileImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  Future<void> changeProfilePhoto() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (image != null) profileImage.value = File(image.path);
  }

  void saveChanges() => Get.back<void>();

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
