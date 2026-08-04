import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

enum AppTextStyle { title, medium, regular, small }

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? underlineColor;
  final AppTextStyle? style;
  final bool? underline;
  final bool? strikeThrough;
  final double? textSize;
  final bool? capitalise;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final double? letterSpacing;
  final double? decorationThickness;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;
  final bool? softWrap;

  const AppText({
    super.key,
    required this.text,
    this.color,
    this.style,
    this.maxLines,
    this.textAlign,
    this.underline,
    this.textSize,
    this.fontWeight,
    this.lineHeight,
    this.fontStyle,
    this.fontFamily,
    this.underlineColor,
    this.strikeThrough,
    this.capitalise,
    this.letterSpacing,
    this.shadows,
    this.overflow,
    this.decorationThickness,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    // 🔤 Apply translation and capitalization safely
    String displayText = text.tr;
    if (capitalise == true) {
      displayText = displayText.toUpperCase();
    }

    return Stack(
      children: [
        Padding(
          padding: underline == true
              ? const EdgeInsets.only(bottom: 0.5)
              : EdgeInsets.zero,
          child: Text(
            displayText,
            softWrap: softWrap,
            maxLines: maxLines,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
            textAlign: textAlign,
            style: getStyle(color ?? AppColors.black, textSize ?? 14),
          ),
        ),
        if (underline == true)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: decorationThickness ?? 1,
              color: underlineColor ?? AppColors.black,
            ),
          ),
      ],
    );
  }

  TextStyle getStyle(Color color, double textSize) {
    final hasDecoration = (underline ?? false) || (strikeThrough ?? false);
    final decoration = strikeThrough == true
        ? TextDecoration.lineThrough
        : (underline == true ? TextDecoration.underline : null);

    return TextStyle(
      overflow: overflow,
      shadows: shadows,
      color: color,
      fontFamily: fontFamily ?? 'PlusJakartaSans',
      letterSpacing: letterSpacing,
      fontWeight: fontWeight ?? getWeight(),
      fontSize: textSize,
      fontStyle: fontStyle ?? FontStyle.normal,
      height: lineHeight ?? 1.2,
      decoration: decoration,
      decorationThickness: hasDecoration ? (decorationThickness ?? 1) : null,
    );
  }

  double getTextSize(double width) {
    switch (style) {
      case AppTextStyle.title:
        return width * 0.08;
      case AppTextStyle.medium:
        return width * 0.06;
      case AppTextStyle.small:
        return width * 0.02;
      default:
        return width * 0.04;
    }
  }

  FontWeight getWeight() {
    switch (style) {
      case AppTextStyle.title:
        return FontWeight.w600;
      case AppTextStyle.medium:
        return FontWeight.w500;
      case AppTextStyle.regular:
        return FontWeight.w400;
      case AppTextStyle.small:
        return FontWeight.w300;
      default:
        return FontWeight.w400;
    }
  }
}
