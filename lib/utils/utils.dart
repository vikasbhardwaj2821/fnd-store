import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../generated/asset_paths.dart';
import 'common/app_colors.dart';
import 'common/app_text.dart';

final GlobalKey<NavigatorState> navigatorKey = Get.key;

abstract final class Utils {
  static OverlayEntry? _snackBarEntry;

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

  /// Shows the FND Store custom overlay snackbar.
  static void showSnackBar(String message) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    _snackBarEntry?.remove();
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: kToolbarHeight,
            child: Material(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(25),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.9,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.fndStoreLogo,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: AppText(
                          text: message,
                          textAlign: TextAlign.center,
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    _snackBarEntry = entry;
    overlay.insert(entry);

    Future<void>.delayed(const Duration(seconds: 3), () {
      if (_snackBarEntry == entry) {
        entry.remove();
        _snackBarEntry = null;
      }
    });
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
