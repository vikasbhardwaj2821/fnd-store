import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/textform_field.dart';
import '../../../utils/utils.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

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
                title: AppStrings.editProfile,
                titleColor: AppColors.primary,
                backIconColor: AppColors.primary,
                height: 64,
                backIconSize: 16,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    18,
                    AppSpacing.screenHorizontal,
                    24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _EditProfilePhoto(controller: controller),
                      const SizedBox(height: 30),
                      _EditField(
                        label: AppStrings.firstName,
                        controller: controller.firstNameController,
                        icon: Icons.person_outline,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 14),
                      _EditField(
                        label: AppStrings.lastName,
                        controller: controller.lastNameController,
                        icon: Icons.badge_outlined,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 14),
                      _EditField(
                        label: AppStrings.emailAddress,
                        controller: controller.emailController,
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 14),
                      _EditField(
                        label: AppStrings.phoneNumber,
                        controller: controller.phoneController,
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                        ],
                      ),
                      const SizedBox(height: 34),
                      AppButton(
                        text: AppStrings.saveChanges,
                        onTap: controller.saveChanges,
                        height: 48,
                        borderRadius: 8,
                        textSize: 15,
                        fontWeight: FontWeight.w600,
                        showShadow: true,
                        trailing: const Icon(
                          Icons.check_circle_outline,
                          color: AppColors.white,
                          size: 16,
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

class _EditProfilePhoto extends StatelessWidget {
  const _EditProfilePhoto({required this.controller});

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: controller.changeProfilePhoto,
          child: SizedBox(
            width: 84,
            height: 84,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Obx(
                    () => ClipOval(
                      child: controller.profileImage.value == null
                          ? Container(
                              padding: const EdgeInsets.all(20),
                              color: AppColors.profilePhotoBackground,
                              child: SvgPicture.asset(
                                Assets.person,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.iconMuted,
                                  BlendMode.srcIn,
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
                  end: -2,
                  bottom: 2,
                  child: Container(
                    width: 27,
                    height: 27,
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
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
        const SizedBox(height: 10),
        const AppText(
          text: AppStrings.changeProfilePhoto,
          color: AppColors.black,
          textSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

class _EditField extends StatelessWidget {
  const _EditField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
  });

  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 7),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: label,
            color: AppColors.black,
            textSize: 10,
            fontWeight: FontWeight.w400,
            capitalise: true,
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Row(
              children: [
                Icon(icon, color: AppColors.disabledButtonText, size: 18),
                const SizedBox(width: 9),
                Expanded(
                  child: CommonTextField(
                    controller: controller,
                    margin: EdgeInsets.zero,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    inputFormatters: inputFormatters,
                    borderSide: false,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: AppColors.white,
                    borderRadius: 0,
                    contentPadding: EdgeInsets.zero,
                    textAlignVertical: TextAlignVertical.center,
                    isDense: true,
                    expands: true,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
