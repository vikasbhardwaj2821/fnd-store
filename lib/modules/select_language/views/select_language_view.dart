import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/asset_paths.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_text.dart';
import '../controllers/select_language_controller.dart';

class SelectLanguageView extends GetView<SelectLanguageController> {
  const SelectLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: AppText(
                          text: AppStrings.selectLanguage,
                          color: AppColors.black,
                          textSize: 22,
                          fontWeight: FontWeight.w800,
                          lineHeight: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Image.asset(
                          Assets.fndStoreLogo,
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Obx(
                        () => _LanguageTile(
                          title: AppStrings.english,
                          leading: const Icon(
                            Icons.translate_rounded,
                            size: 30,
                          ),
                          isSelected:
                              controller.selectedLanguage.value ==
                              AppLanguage.english,
                          onTap: () =>
                              controller.selectLanguage(AppLanguage.english),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Obx(
                        () => _LanguageTile(
                          title: AppStrings.arabic,
                          leading: const AppText(
                            text: AppStrings.arabicSymbol,
                            textSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                          isSelected:
                              controller.selectedLanguage.value ==
                              AppLanguage.arabic,
                          onTap: () =>
                              controller.selectLanguage(AppLanguage.arabic),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 40),
                      AppButton(
                        text: AppStrings.continueText,
                        onTap: controller.continueToOnboarding,
                        height: 52,
                        borderRadius: 12,
                        showShadow: false,
                      ),
                      const SizedBox(height: 34),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.title,
    required this.leading,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final Widget leading;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.primary
        : AppColors.languageTileBorder;
    final contentColor = isSelected ? AppColors.black : AppColors.textDisabled;
    final radioColor = isSelected ? AppColors.primary : AppColors.radioDisabled;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 62,
          padding: const EdgeInsetsDirectional.only(start: 16, end: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 36,
                child: IconTheme(
                  data: IconThemeData(color: contentColor),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: contentColor),
                    child: leading,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppText(
                  text: title,
                  color: contentColor,
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: radioColor, width: 2),
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
