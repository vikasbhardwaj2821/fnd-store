import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../dashboard/controllers/settings_controller.dart';

class CmsView extends StatefulWidget {
  const CmsView({super.key});

  @override
  State<CmsView> createState() => _CmsViewState();
}

class _CmsViewState extends State<CmsView> {
  final SettingsController _controller = Get.find<SettingsController>();
  late final bool _isPrivacy;

  @override
  void initState() {
    super.initState();
    _isPrivacy = Get.currentRoute == AppRoutes.privacyPolicy;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getCms(_isPrivacy ? 'privacy-policy' : 'terms');
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = _isPrivacy
        ? AppStrings.privacyPolicyTitle
        : AppStrings.termsAndConditions;

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
              child: Obx(() {
                final description = _controller.cms.value?.description;
                if (description == null || description.isEmpty) {
                  return const SizedBox.shrink();
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    14,
                    AppSpacing.screenHorizontal,
                    28,
                  ),
                  child: Html(
                    data: description,
                    style: {
                      'body': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        color: AppColors.black,
                        fontFamily: 'PlusJakartaSans',
                        fontSize: FontSize(12),
                        lineHeight: const LineHeight(1.45),
                      ),
                      'h1': Style(
                        color: AppColors.primary,
                        fontSize: FontSize(20),
                        fontWeight: FontWeight.w700,
                      ),
                      'h2': Style(
                        color: AppColors.primary,
                        fontSize: FontSize(16),
                        fontWeight: FontWeight.w700,
                      ),
                      'h3': Style(
                        color: AppColors.primary,
                        fontSize: FontSize(14),
                        fontWeight: FontWeight.w700,
                      ),
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
