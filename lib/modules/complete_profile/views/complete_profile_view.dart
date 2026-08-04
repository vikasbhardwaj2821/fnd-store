import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/common/country_bottomsheet.dart';
import '../../../utils/common/textform_field.dart';
import '../../../utils/utils.dart';
import '../controllers/complete_profile_controller.dart';

const double _profileFieldHeight = 52;
const double _profileFieldRadius = 12;

class CompleteProfileView extends GetView<CompleteProfileController> {
  const CompleteProfileView({super.key});

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
                title: AppStrings.completeProfile,
                titleColor: AppColors.black,
                backIconColor: AppColors.black,
                height: 64,
                backIconSize: 16,
                showBottomBorder: false,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    20,
                    AppSpacing.screenHorizontal,
                    24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ProfilePhoto(controller: controller),
                      const SizedBox(height: 20),
                      _ProfileField(
                        label: AppStrings.firstName,
                        hint: AppStrings.firstNameHint,
                        controller: controller.firstNameController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      _ProfileField(
                        label: AppStrings.lastName,
                        hint: AppStrings.lastNameHint,
                        controller: controller.lastNameController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      _ProfileField(
                        label: AppStrings.email,
                        hint: AppStrings.emailHint,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      _PhoneField(controller: controller),
                      const SizedBox(height: 14),
                      _TermsAgreement(controller: controller),
                      const SizedBox(height: 28),
                      AppButton(
                        text: AppStrings.continueText,
                        onTap: controller.continueToStore,
                        height: 52,
                        borderRadius: 12,
                        showShadow: false,
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const AppText(
                              text: AppStrings.alreadyHaveAccount,
                              color: AppColors.black,
                              textSize: 13,
                            ),
                            GestureDetector(
                              onTap: controller.openSignIn,
                              child: const AppText(
                                text: AppStrings.signIn,
                                color: AppColors.primary,
                                textSize: 13,
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
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({required this.controller});

  final CompleteProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.openPhotoPicker(context),
          child: SizedBox(
            width: 82,
            height: 82,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: controller.profileImage.value == null
                          ? ColoredBox(
                              color: AppColors.profilePhotoBackground,
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.person,
                                  width: 38,
                                  height: 38,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.iconMuted,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            )
                          : Image.file(
                              controller.profileImage.value!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  end: -7,
                  bottom: -4,
                  child: Container(
                    width: 31,
                    height: 31,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: SvgPicture.asset(
                      Assets.cameraNew,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 9),
        const AppText(
          text: AppStrings.addProfilePhotoOptional,
          color: AppColors.textSecondary,
          textSize: 12,
        ),
      ],
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: label, color: AppColors.textDisabled, textSize: 11),
        const SizedBox(height: 5),
        SizedBox(
          height: _profileFieldHeight,
          child: CommonTextField(
            controller: controller,
            margin: EdgeInsets.zero,
            hintText: hint,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            borderRadius: _profileFieldRadius,
            fillColor: AppColors.white,
            borderColor: AppColors.fieldBorder,
            focusBorderColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            textAlignVertical: TextAlignVertical.center,
            isDense: false,
            fontSize: 14,
            hintSize: 14,
          ),
        ),
      ],
    );
  }
}

class _TermsAgreement extends StatelessWidget {
  const _TermsAgreement({required this.controller});

  final CompleteProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Obx(
            () => Checkbox(
              value: controller.acceptedTerms.value,
              onChanged: controller.toggleTerms,
              activeColor: AppColors.primary,
              side: const BorderSide(color: AppColors.fieldBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        const AppText(
          text: AppStrings.agreeWith,
          color: AppColors.black,
          textSize: 13,
          fontWeight: FontWeight.w500,
        ),
        GestureDetector(
          onTap: () => Get.toNamed<void>(AppRoutes.termsAndConditions),
          child: const AppText(
            text: AppStrings.termsAndConditions,
            color: AppColors.primary,
            textSize: 14,
            fontWeight: FontWeight.w700,
            underline: true,
            underlineColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller});

  final CompleteProfileController controller;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.phoneNumber,
          color: AppColors.orLoginWith,
          textSize: 12,
        ),
        const SizedBox(height: 5),
        Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CountrySelector(
                country: controller.selectedCountry.value,
                onTap: () => _pickCountry(context),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: _profileFieldHeight,
                  child: CommonTextField(
                    controller: controller.phoneController,
                    margin: EdgeInsets.zero,
                    hintText: AppStrings.phoneHint,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                        controller.selectedCountry.value.maxLength,
                      ),
                    ],
                    borderRadius: _profileFieldRadius,
                    fillColor: AppColors.white,
                    borderColor: AppColors.fieldBorder,
                    focusBorderColor: AppColors.primary,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    isDense: false,
                    fontSize: 14,
                    hintSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CountrySelector extends StatelessWidget {
  const _CountrySelector({required this.country, required this.onTap});

  final Country country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(_profileFieldRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_profileFieldRadius),
        child: Container(
          height: _profileFieldHeight,
          padding: const EdgeInsetsDirectional.only(start: 10, end: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_profileFieldRadius),
            border: Border.all(color: AppColors.fieldBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(text: country.flag ?? '', textSize: 18),
              const SizedBox(width: 4),
              AppText(
                text: '+${country.dialCode}',
                color: AppColors.black,
                textSize: 13,
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
    );
  }
}
