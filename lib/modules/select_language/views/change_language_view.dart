import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../controllers/select_language_controller.dart';

class ChangeLanguageView extends GetView<SelectLanguageController> {
  const ChangeLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: AppStrings.changeLanguage,
              titleColor: AppColors.primary,
              backIconColor: AppColors.primary,
              height: 64,
              centerTitle: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  32,
                  AppSpacing.screenHorizontal,
                  30,
                ),
                child: Column(
                  children: [
                    Obx(
                      () => _ChangeLanguageTile(
                        title: AppStrings.english,
                        leading: const Icon(Icons.translate_rounded, size: 28),
                        selected:
                            controller.selectedLanguage.value ==
                            AppLanguage.english,
                        onTap: () =>
                            controller.selectLanguage(AppLanguage.english),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Obx(
                      () => _ChangeLanguageTile(
                        title: AppStrings.arabic,
                        leading: const AppText(
                          text: AppStrings.arabicSymbol,
                          textSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                        selected:
                            controller.selectedLanguage.value ==
                            AppLanguage.arabic,
                        onTap: () =>
                            controller.selectLanguage(AppLanguage.arabic),
                      ),
                    ),
                    const Spacer(),
                    AppButton(
                      text: AppStrings.continueText,
                      onTap: controller.saveAndGoBack,
                      height: 52,
                      borderRadius: 12,
                      showShadow: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangeLanguageTile extends StatelessWidget {
  const _ChangeLanguageTile({
    required this.title,
    required this.leading,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final Widget leading;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textDisabled;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 62,
        padding: const EdgeInsetsDirectional.only(start: 16, end: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.languageTileBorder,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: IconTheme(
                data: IconThemeData(color: color),
                child: leading,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AppText(
                text: title,
                color: color,
                textSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.radioDisabled,
                  width: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
