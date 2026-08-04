import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/country_bottomsheet.dart';
import '../../../utils/common/textform_field.dart';
import '../../../utils/utils.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Utils.hideKeyboard(context),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.authHorizontal,
              12,
              AppSpacing.authHorizontal,
              12,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.sizeOf(context).height -
                    MediaQuery.paddingOf(context).vertical -
                    38,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Image.asset(
                        Assets.fndStoreLogo,
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const AppText(
                      text: AppStrings.loginPhoneTitle,
                      color: AppColors.black,
                      textSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 12),
                    const AppText(
                      text: AppStrings.loginPhoneDescription,
                      color: AppColors.textSecondary,
                      textSize: 13,
                      lineHeight: 1.5,
                    ),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () => Get.toNamed<void>(AppRoutes.privacyPolicy),
                      child: const AppText(
                        text: AppStrings.phonePrivacyNote,
                        color: AppColors.textSecondary,
                        textSize: 12,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _PhoneInput(controller: controller),
                    const SizedBox(height: 26),
                    AppButton(
                      text: AppStrings.continueText,
                      onTap: controller.continueWithPhone,
                      height: 58,
                      borderRadius: 14,
                      showShadow: false,
                    ),
                    const SizedBox(height: 64),
                    const Center(
                      child: AppText(
                        text: AppStrings.orContinueWith,
                        color: AppColors.orLoginWith,
                        textSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialButton(
                          icon: Assets.googleIcon,
                          onTap: controller.continueWithGoogle,
                        ),
                        const SizedBox(width: 16),
                        _SocialButton(
                          icon: Assets.appleIcon,
                          onTap: controller.continueWithApple,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const SizedBox(height: 24),
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const AppText(
                            text: AppStrings.dontHaveAccount,
                            color: AppColors.black,
                            textSize: 13,
                          ),
                          GestureDetector(
                            onTap: controller.openSignUp,
                            child: const AppText(
                              text: AppStrings.signUp,
                              color: AppColors.primary,
                              textSize: 14,
                              fontWeight: FontWeight.w700,
                              underline: true,
                              underlineColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput({required this.controller});

  final LoginController controller;

  Future<void> _pickCountry(BuildContext context) async {
    final country = await showCountryPicker(
      context,
      selectedCountry: controller.selectedCountry.value,
    );

    if (country != null) {
      controller.selectCountry(country);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 58,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.fieldBorder),
        ),
        child: Row(
          children: [
            Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: () => _pickCountry(context),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12, end: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        text: controller.selectedCountry.value.flag ?? '',
                        textSize: 18,
                      ),
                      const SizedBox(width: 5),
                      AppText(
                        text: '+${controller.selectedCountry.value.dialCode}',
                        color: AppColors.black,
                        textSize: 14,
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.textSecondary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 26,
              child: VerticalDivider(
                width: 1,
                thickness: 1,
                color: AppColors.fieldBorder,
              ),
            ),
            Expanded(
              child: CommonTextField(
                controller: controller.phoneController,
                margin: EdgeInsets.zero,
                hintText: AppStrings.loginPhoneHint,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                    controller.selectedCountry.value.maxLength,
                  ),
                ],
                borderSide: false,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                fillColor: AppColors.white,
                borderRadius: 0,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                textAlignVertical: TextAlignVertical.center,
                isDense: true,
                expands: true,
                fontSize: 14,
                hintSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: '',
      onTap: onTap,
      width: 54,
      height: 54,
      borderRadius: 12,
      borderWidth: 1,
      borderColor: AppColors.fieldBorder,
      backgroundColor: AppColors.white,
      icon1: icon,
      widthIcon1: 20,
      heightIcon1: 20,
      padding: EdgeInsets.zero,
      showShadow: false,
    );
  }
}
