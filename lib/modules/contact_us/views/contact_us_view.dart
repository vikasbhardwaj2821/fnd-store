import 'package:flutter/material.dart';
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
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});

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
                title: AppStrings.contactUs,
                titleColor: AppColors.primary,
                backIconColor: AppColors.primary,
                height: 64,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    14,
                    AppSpacing.screenHorizontal,
                    24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ContactField(
                        label: 'Subject',
                        hint: 'Enter subject',
                        controller: controller.subjectController,
                        prefix: Icons.edit_note_outlined,
                      ),
                      const SizedBox(height: 14),
                      _ContactField(
                        label: AppStrings.description,
                        hint: 'Enter your message',
                        controller: controller.descriptionController,
                        height: 126,
                        maxLines: 6,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                      const SizedBox(height: 28),
                      Container(
                        height: 58,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.softPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                Assets.callIcon,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: AppStrings.callSupport,
                                  color: AppColors.black,
                                  textSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 2),
                                AppText(
                                  text: AppStrings.supportPhone,
                                  color: AppColors.textSecondary,
                                  textSize: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 58),
                      AppButton(
                        text: AppStrings.submit,
                        onTap: controller.submit,
                        height: 48,
                        borderRadius: 8,
                        showShadow: false,
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

class _ContactField extends StatelessWidget {
  const _ContactField({
    required this.label,
    required this.hint,
    required this.controller,
    this.prefix,
    this.height = 52,
    this.maxLines = 1,
    this.textAlignVertical = TextAlignVertical.center,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData? prefix;
  final double height;
  final int maxLines;
  final TextAlignVertical textAlignVertical;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: label, color: AppColors.black, textSize: 12),
        const SizedBox(height: 6),
        SizedBox(
          height: height,
          child: CommonTextField(
            controller: controller,
            margin: EdgeInsets.zero,
            hintText: hint,
            maxLines: maxLines,
            prefixIcon: prefix == null
                ? null
                : Icon(prefix, color: AppColors.textSecondary, size: 18),
            prefixIconConstraints: const BoxConstraints(minWidth: 40),
            borderRadius: 12,
            fillColor: AppColors.white,
            borderColor: AppColors.fieldBorder,
            focusBorderColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            textAlignVertical: textAlignVertical,
            isDense: false,
            fontSize: 14,
            hintSize: 14,
          ),
        ),
      ],
    );
  }
}
