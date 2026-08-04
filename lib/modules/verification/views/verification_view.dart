import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/utils.dart';
import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Utils.hideKeyboard(context),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(
                title: AppStrings.verificationCode,
                titleColor: AppColors.black,
                backIconColor: AppColors.black,
                height: 64,
                backIconSize: 16,
                showBottomBorder: false,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(32, 34, 32, 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: const AppText(
                          text: AppStrings.verificationDescription,
                          color: AppColors.black,
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          lineHeight: 1.35,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 34),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          const fieldGap = 9.0;
                          final fieldWidth =
                              (constraints.maxWidth - (fieldGap * 3)) / 4;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              controller.codeControllers.length,
                              (index) => SizedBox(
                                width: fieldWidth,
                                height: 64,
                                child: _CodeField(
                                  controller: controller.codeControllers[index],
                                  focusNode: controller.focusNodes[index],
                                  autofocus: index == 0,
                                  onChanged: (value) =>
                                      controller.onCodeChanged(index, value),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 44),
                      AppButton(
                        text: AppStrings.continueText,
                        onTap: controller.verifyCode,
                        height: 56,
                        borderRadius: 14,
                        showShadow: false,
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Obx(
                          () => GestureDetector(
                            onTap: controller.resendCode,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time_outlined,
                                  color: AppColors.textPrimary,
                                  size: 17,
                                ),
                                const SizedBox(width: 6),
                                AppText(
                                  text: controller.resendSeconds.value == 0
                                      ? AppStrings.resendCode
                                      : AppStrings.resendIn,
                                  color: AppColors.textPrimary,
                                  textSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                if (controller.resendSeconds.value > 0)
                                  AppText(
                                    text: ' ${controller.resendSeconds.value}s',
                                    color: AppColors.countdown,
                                    textSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CodeField extends StatelessWidget {
  const _CodeField({
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      maxLength: 1,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontFamily: 'PlusJakartaSans',
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
    );
  }
}
