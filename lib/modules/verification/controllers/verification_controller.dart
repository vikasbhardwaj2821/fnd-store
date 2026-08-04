import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../utils/utils.dart';

class VerificationController extends GetxController {
  final codeControllers = List.generate(4, (_) => TextEditingController());
  final focusNodes = List.generate(4, (_) => FocusNode());
  final RxInt resendSeconds = 30.obs;

  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    _startResendTimer();
  }

  void onCodeChanged(int index, String value) {
    if (value.isNotEmpty && index < focusNodes.length - 1) {
      focusNodes[index + 1].requestFocus();
      return;
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void verifyCode() {
    Utils.hideKeyboard(Get.context!);
    Get.offAllNamed<void>(AppRoutes.home);
  }

  void resendCode() {
    if (resendSeconds.value > 0) return;

    for (final field in codeControllers) {
      field.clear();
    }
    focusNodes.first.requestFocus();
    resendSeconds.value = 30;
    _startResendTimer();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value == 0) {
        timer.cancel();
        return;
      }
      resendSeconds.value--;
    });
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    for (final controller in codeControllers) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}
