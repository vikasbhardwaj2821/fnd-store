import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'app_strings.dart';
import 'common/app_colors.dart';

abstract final class Utils {
  static Map<String, dynamic> _decodeJwtPart(String part) {
    final normalized = base64Url.normalize(part);
    final decoded = utf8.decode(base64Url.decode(normalized));
    return jsonDecode(decoded) as Map<String, dynamic>;
  }

  static String decodeAppleJws(String jws) {
    final parts = jws.split('.');
    if (parts.length != 3) return '';

    try {
      final payload = _decodeJwtPart(parts[1]);
      return payload['originalTransactionId']?.toString() ?? '';
    } on FormatException {
      return '';
    }
  }

  static String formatNumber(String? number) {
    if (number == null || number.trim().isEmpty) return '';
    final parsedNumber = num.tryParse(number);
    return parsedNumber == null
        ? number
        : NumberFormat('#,###').format(parsedNumber);
  }

  static void showLoading() {
    if (Get.isDialogOpen ?? false) return;

    Get.dialog<void>(
      PopScope(
        canPop: false,
        child: Center(
          child: Platform.isIOS
              ? const CupertinoActivityIndicator(
                  radius: 13,
                  color: AppColors.white,
                )
              : const CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  static void showSnackBar(String message, {bool isError = false}) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    Get.snackbar(
      isError ? AppStrings.error.tr : AppStrings.appName.tr,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? AppColors.error : AppColors.primary,
      colorText: AppColors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static String formatDate(DateTime date, {String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(date);
  }
}

extension StringTitleCase on String {
  String toTitleCase() {
    return trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
