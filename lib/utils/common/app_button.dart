import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_colors.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? borderWidth;
  final double? borderRadius;
  final double? scale;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final double? textSize;
  final double? elevation;
  final double? height;
  final bool? capitalise;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? margin;
  final String? icon1;
  final Color? color;
  final String? icon2;
  final Widget? trailing;
  final String? fontFamily;
  final double? heightIcon1;
  final double? widthIcon1;
  final double? heightIcon2;
  final double? widthIcon2;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool showShadow;

  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.textColor,
    this.iconColor,
    this.borderColor,
    this.textSize,
    this.fontWeight,
    this.height,
    this.capitalise,
    this.borderRadius,
    this.borderWidth,
    this.elevation,
    this.margin,
    this.icon1,
    this.icon2,
    this.trailing,
    this.fontFamily,
    this.color,
    this.scale,
    this.padding,
    this.heightIcon1,
    this.widthIcon1,
    this.heightIcon2,
    this.widthIcon2,
    this.backgroundColor,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: AppColors.buttonShadow,
                  blurRadius: 6,
                  spreadRadius: -4,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: AppColors.buttonShadow,
                  blurRadius: 15,
                  spreadRadius: -3,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Material(
        color: backgroundColor ?? color ?? AppColors.primary,
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 14),
              border: Border.all(
                color: borderColor ?? AppColors.transparent,
                width: borderWidth ?? 0,
              ),
            ),
            width: width ?? double.infinity,
            height: height ?? 56,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon1 != null)
                  Padding(
                    padding: EdgeInsets.only(right: text.isEmpty ? 0 : 10),
                    child: SvgPicture.asset(
                      icon1!,
                      height: heightIcon1 ?? 24,
                      width: widthIcon1 ?? 24,
                      colorFilter: iconColor == null
                          ? null
                          : ColorFilter.mode(iconColor!, BlendMode.srcIn),
                    ),
                  ),
                if (text.isNotEmpty)
                  Flexible(
                    child: AppText(
                      text: text,
                      capitalise: capitalise,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      color: textColor ?? AppColors.white,
                      fontFamily: fontFamily,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      textSize: textSize ?? 16,
                      lineHeight: 1.5,
                      letterSpacing: 0,
                    ),
                  ),
                if (icon2 != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      icon2!,
                      height: heightIcon2 ?? 24,
                      width: widthIcon2 ?? 24,
                      colorFilter: iconColor == null
                          ? null
                          : ColorFilter.mode(iconColor!, BlendMode.srcIn),
                    ),
                  ),
                if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: trailing!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const LoginButton({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(image, height: 22, width: 22),
            SizedBox(width: 10),
            AppText(
              text: text,
              textSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onTap;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 17,
        width: 17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isChecked ? AppColors.primary : AppColors.transparent,
          border: isChecked
              ? null
              : Border.all(color: AppColors.white70, width: 1.5),
        ),
        child: isChecked
            ? const Icon(Icons.check, color: AppColors.white, size: 15)
            : null,
      ),
    );
  }
}
