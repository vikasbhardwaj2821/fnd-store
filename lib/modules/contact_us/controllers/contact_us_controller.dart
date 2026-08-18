import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/support_api_provider.dart';
import '../../../utils/utils.dart';

class ContactUsController extends GetxController {
  ContactUsController(this._apiProvider);

  final SupportApiProvider _apiProvider;
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> submit() async {
    final body = <String, dynamic>{
      'subject': subjectController.text.trim(),
      'message': descriptionController.text.trim(),
    };
    if (body['subject']!.isEmpty || body['message']!.isEmpty) {
      Utils.showSnackBar('Please fill all required fields.');
      return;
    }

    final response = await _apiProvider.sendSupportMessage(body);
    if (response.success) {
      Utils.showSnackBar(
        response.message ?? 'Your message has been sent successfully.',
      );
      Get.back<void>();
      return;
    }

    Utils.showSnackBar(
      response.message ?? 'Unable to send message. Please try again.',
    );
  }

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
