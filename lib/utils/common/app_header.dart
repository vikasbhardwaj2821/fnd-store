import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/asset_paths.dart';
import '../app_spacing.dart';
import 'app_colors.dart';
import 'app_text.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.onBack,
    this.title,
    this.trailing,
    this.backIconColor,
    this.titleColor,
    this.height = 48,
    this.backIconSize = 16,
    this.showBottomBorder = true,
    this.centerTitle = false,
  });

  final VoidCallback? onBack;
  final String? title;
  final Widget? trailing;
  final Color? backIconColor;
  final Color? titleColor;
  final double height;
  final double backIconSize;
  final bool showBottomBorder;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: showBottomBorder
            ? const Border(bottom: BorderSide(color: AppColors.border))
            : null,
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: onBack ?? Get.back<void>,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.fieldBorder),
                  ),
                  child: Image.asset(
                    Assets.backButton,
                    width: backIconSize,
                    height: backIconSize,
                    color: backIconColor ?? AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          if (title != null)
            if (centerTitle)
              AppText(
                text: title!,
                color: titleColor ?? AppColors.primary,
                textSize: 18,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              )
            else
              PositionedDirectional(
                start: 48,
                end: trailing == null ? 0 : 48,
                child: AppText(
                  text: title!,
                  color: titleColor ?? AppColors.primary,
                  textSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
          if (trailing != null)
            Align(alignment: AlignmentDirectional.centerEnd, child: trailing),
        ],
      ),
    );
  }
}
