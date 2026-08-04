import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();

  void submit() => Get.back<void>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
