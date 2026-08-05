import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsView> {
  bool _notificationsEnabled = true;

  void _showAccountActionDialog({required bool isDelete}) {
    Get.dialog<void>(
      _AccountActionDialog(
        isDelete: isDelete,
        onConfirm: () => Get.offAllNamed<void>(AppRoutes.login),
      ),
      barrierDismissible: false,
      barrierColor: AppColors.black42,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.pageBackground,
      child: Column(
        children: [
          const AppHeader(
            title: AppStrings.settings,
            titleColor: AppColors.primary,
            height: 64,
            showBottomBorder: true,
            centerTitle: true,
            showBackButton: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 84,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppStrings.appSettings,
                          color: AppColors.disabledButtonText,
                          textSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 3),
                        AppText(
                          text: AppStrings.appSettingsDescription,
                          color: AppColors.white70,
                          textSize: 11,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const _SettingsSectionLabel(text: AppStrings.preferences),
                  const SizedBox(height: 7),
                  _SettingsCard(
                    children: [
                      _SettingsRow(
                        icon: Assets.notificationIcon,
                        label: AppStrings.notifications,
                        trailing: Transform.scale(
                          scale: 0.82,
                          child: Switch(
                            value: _notificationsEnabled,
                            onChanged: (value) =>
                                setState(() => _notificationsEnabled = value),
                            activeTrackColor: AppColors.primary,
                            activeThumbColor: AppColors.white,
                            inactiveTrackColor: AppColors.border,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const _SettingsSectionLabel(text: AppStrings.legalAndSupport),
                  const SizedBox(height: 7),
                  _SettingsCard(
                    children: [
                      _SettingsRow(
                        icon: Assets.storeDetails,
                        label: AppStrings.storeDetails,
                        showArrow: true,
                        onTap: () => Get.toNamed<void>(
                          AppRoutes.storeDetails,
                          arguments: const {'editMode': true},
                        ),
                      ),
                      _SettingsRow(
                        icon: Assets.changeLanguage,
                        label: AppStrings.changeLanguage,
                        showArrow: true,
                        onTap: () =>
                            Get.toNamed<void>(AppRoutes.changeLanguage),
                      ),
                      _SettingsRow(
                        icon: Assets.settingsTerms,
                        label: AppStrings.termsAndConditions,
                        showArrow: true,
                        onTap: () =>
                            Get.toNamed<void>(AppRoutes.termsAndConditions),
                      ),
                      _SettingsRow(
                        icon: Assets.privacyPolicy,
                        label: AppStrings.privacyPolicies,
                        showArrow: true,
                        onTap: () => Get.toNamed<void>(AppRoutes.privacyPolicy),
                      ),
                      _SettingsRow(
                        icon: Assets.contactUs,
                        label: AppStrings.contactUs,
                        showArrow: true,
                        showDivider: false,
                        onTap: () => Get.toNamed<void>(AppRoutes.contactUs),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const _SettingsSectionLabel(text: AppStrings.accountActions),
                  const SizedBox(height: 7),
                  _SettingsCard(
                    children: [
                      _SettingsRow(
                        icon: Assets.settingsLogout,
                        label: AppStrings.logout,
                        onTap: () => _showAccountActionDialog(isDelete: false),
                      ),
                      _SettingsRow(
                        icon: Assets.deleteAccount,
                        label: AppStrings.deleteAccount,
                        color: AppColors.countdown,
                        showDivider: false,
                        onTap: () => _showAccountActionDialog(isDelete: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 34),
                  const Center(
                    child: AppText(
                      text: AppStrings.appVersion,
                      color: AppColors.textSecondary,
                      textSize: 10,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: AppText(
                      text: AppStrings.managedBy,
                      color: AppColors.textDisabled,
                      textSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountActionDialog extends StatelessWidget {
  const _AccountActionDialog({required this.isDelete, required this.onConfirm});

  final bool isDelete;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final accent = isDelete ? AppColors.countdown : AppColors.primary;
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDelete ? AppColors.surface : AppColors.softPrimary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  isDelete ? Assets.deleteAccount : Assets.settingsLogout,
                  colorFilter: ColorFilter.mode(accent, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 12),
              AppText(
                text: isDelete
                    ? AppStrings.deleteConfirmation
                    : AppStrings.logoutConfirmation,
                color: AppColors.black,
                textSize: 18,
                fontWeight: FontWeight.w800,
                lineHeight: 1.3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              AppText(
                text: isDelete
                    ? AppStrings.deleteDescription
                    : AppStrings.logoutDescription,
                color: AppColors.textSecondary,
                textSize: 12,
                lineHeight: 1.35,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              AppButton(
                text: isDelete ? AppStrings.yesDelete : AppStrings.yesLogout,
                onTap: onConfirm,
                height: 50,
                borderRadius: 8,
                textSize: 14,
                backgroundColor: accent,
                showShadow: false,
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: Get.back<void>,
                child: AppText(
                  text: isDelete
                      ? AppStrings.keepAccount
                      : AppStrings.staySignedIn,
                  color: AppColors.primary,
                  textSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSectionLabel extends StatelessWidget {
  const _SettingsSectionLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => AppText(
    text: text,
    color: AppColors.textSecondary,
    textSize: 12,
    fontWeight: FontWeight.w500,
    capitalise: true,
  );
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    this.trailing,
    this.showArrow = false,
    this.showDivider = true,
    this.color,
    this.onTap,
  });

  final String icon;
  final String label;
  final Widget? trailing;
  final bool showArrow;
  final bool showDivider;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? AppColors.black;
    return Container(
      height: 51,
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.fieldBorder))
            : null,
      ),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 17,
                height: 17,
                colorFilter: color == null
                    ? null
                    : ColorFilter.mode(color!, BlendMode.srcIn),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppText(
                  text: label,
                  color: foreground,
                  textSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (trailing != null)
                trailing!
              else if (showArrow)
                SvgPicture.asset(Assets.settingsArrow, width: 8, height: 13),
            ],
          ),
        ),
      ),
    );
  }
}
