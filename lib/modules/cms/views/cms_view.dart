import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';

class CmsView extends StatelessWidget {
  const CmsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPrivacy = Get.currentRoute == AppRoutes.privacyPolicy;
    final title = isPrivacy
        ? AppStrings.privacyPolicyTitle
        : AppStrings.termsAndConditions;
    final notice = isPrivacy
        ? AppStrings.privacyNotice
        : AppStrings.termsNotice;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              title: title,
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
                  14,
                  AppSpacing.screenHorizontal,
                  28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            text: AppStrings.lastUpdated,
                            color: AppColors.textSecondary,
                            textSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                          const SizedBox(height: 16),
                          AppText(
                            text: notice,
                            color: AppColors.black,
                            textSize: 11,
                            lineHeight: 1.45,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _CmsHeading(text: AppStrings.introduction),
                    const SizedBox(height: 8),
                    const AppText(
                      text: AppStrings.introductionBody,
                      color: AppColors.black,
                      textSize: 11,
                      lineHeight: 1.45,
                    ),
                    const SizedBox(height: 18),
                    const _CmsHeading(text: AppStrings.responsibilities),
                    const SizedBox(height: 8),
                    const AppText(
                      text: AppStrings.responsibilitiesBody,
                      color: AppColors.black,
                      textSize: 11,
                      lineHeight: 1.45,
                    ),
                    const SizedBox(height: 10),
                    const _CmsBullet(text: AppStrings.responsibilityOne),
                    const _CmsBullet(text: AppStrings.responsibilityTwo),
                    const _CmsBullet(text: AppStrings.responsibilityThree),
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

class _CmsHeading extends StatelessWidget {
  const _CmsHeading({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => AppText(
    text: text,
    color: AppColors.primary,
    textSize: 13,
    fontWeight: FontWeight.w700,
  );
}

class _CmsBullet extends StatelessWidget {
  const _CmsBullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 14, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(text: '•', color: AppColors.black, textSize: 11),
          const SizedBox(width: 8),
          Expanded(
            child: AppText(
              text: text,
              color: AppColors.black,
              textSize: 11,
              lineHeight: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
