import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../data/network/auth_api_provider.dart';
import '../../../data/shared/auth_session.dart';
import '../../../data/validators/validator.dart';
import '../../../utils/utils.dart';

class VerificationController extends GetxController {
  VerificationController(this._apiProvider);

  final AuthApiProvider _apiProvider;
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

  Future<void> verifyCode() async {
    Utils.hideKeyboard(Get.context!);

    if (!Validator.validateOtp(codeControllers)) return;

    final arguments = Get.arguments;
    final isSignup = arguments is Map && arguments['flow'] == 'signup';
    final mobileNumber = arguments is Map
        ? arguments['mobile_number']?.toString()
        : null;
    if (mobileNumber == null || mobileNumber.isEmpty) {
      Utils.showSnackBar('Mobile number is missing.');
      return;
    }

    final body = {
      'mobile_number': mobileNumber,
      'otp': codeControllers.map((controller) => controller.text.trim()).join(),
    };
    final response = isSignup
        ? await _apiProvider.verifySignupOtp(body)
        : await _apiProvider.verifyOtp(body);

    if (response.success && response.body != null) {
      await AuthSession.instance.setUser(response.body!);
      Get.offAllNamed<void>(
        isSignup ? AppRoutes.storeDetails : AppRoutes.dashboard,
        arguments: {'user': response.body},
      );
      return;
    }

    Utils.showSnackBar(
      response.message ?? 'Unable to verify OTP. Please try again.',
    );
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
