import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class CommonTextField extends StatelessWidget {
  final String? title;
  final FontWeight? titleFontWeight;
  final double? titleSpacing;
  final Color? titleColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final double? titleSize;
  final String? hintText;
  final String? counterText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isDense;
  final Color? hintTextColor;
  final Color? textColor;
  final Color? cursorColor;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool expands;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? enabled;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final InputBorder? inputBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsets? scrollPadding;
  final Color? fillColor;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextAlignVertical? textAlignVertical;
  final double? elevation;
  final double? fontSize;
  final double? hintSize;
  final String? fontFamily;
  final String? hintFontFamily;
  final FontWeight? fontWeight;
  final FontWeight? hintWeight;
  final TextAlign? textAlign;
  final double? cursorHeight;
  final bool? borderSide;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;

  const CommonTextField({
    super.key,
    this.title,
    this.titleFontWeight,
    this.titleSpacing,
    this.titleColor,
    this.borderColor,
    this.focusBorderColor,
    this.titleSize,
    this.hintText,
    this.counterText,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense,
    this.hintTextColor,
    this.textColor,
    this.cursorColor,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.expands = false,
    this.readOnly,
    this.textInputAction,
    this.keyboardType,
    this.enabled,
    this.validator,
    this.controller,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.textCapitalization,
    this.inputBorder,
    this.focusedBorder,
    this.enabledBorder,
    this.contentPadding,
    this.scrollPadding,
    this.fillColor,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.borderRadius,
    this.margin,
    this.padding,
    this.textAlignVertical,
    this.elevation,
    this.fontSize,
    this.hintSize,
    this.fontFamily,
    this.hintFontFamily,
    this.fontWeight,
    this.hintWeight,
    this.textAlign,
    this.cursorHeight,
    this.borderSide,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    const Color focusedColor = AppColors.primary;
    final Color unfocusedColor = borderColor ?? AppColors.border;
    final Color resolvedFocusedColor = focusBorderColor ?? focusedColor;
    const Color backgroundColor = AppColors.white;

    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(vertical: 11),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          obscureText: obscureText ?? false,
          obscuringCharacter: '●',
          readOnly: readOnly ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          textInputAction: textInputAction ?? TextInputAction.done,
          enabled: enabled,
          expands: expands,
          maxLines: expands ? null : maxLines ?? 1,
          minLines: expands ? null : minLines,
          maxLength: maxLength,
          textAlign: textAlign ?? TextAlign.start,
          textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
          inputFormatters: inputFormatters, // ✅ preserved
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          onChanged: onChanged,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          cursorColor: cursorColor ?? resolvedFocusedColor,
          cursorHeight: cursorHeight ?? 20,
          cursorWidth: 1.2,
          scrollPadding: scrollPadding ?? const EdgeInsets.all(20),
          style: TextStyle(
            color: textColor ?? AppColors.black,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: fontSize ?? 16,
            fontFamily: fontFamily ?? 'PlusJakartaSans',
          ),
          decoration: InputDecoration(
            counterText: counterText,
            isDense: isDense ?? false,
            filled: true,
            fillColor: fillColor ?? backgroundColor,
            hintText: hintText?.tr,
            hintStyle: TextStyle(
              color: hintTextColor ?? AppColors.hintText,
              fontWeight: hintWeight ?? FontWeight.w500,
              fontSize: hintSize ?? 14,
              fontFamily: hintFontFamily ?? 'PlusJakartaSans',
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            prefixIconConstraints:
                prefixIconConstraints ??
                const BoxConstraints(minWidth: 24, minHeight: 24),
            suffixIconConstraints:
                suffixIconConstraints ??
                const BoxConstraints(minWidth: 24, minHeight: 24),
            contentPadding:
                contentPadding ??
                const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            enabledBorder:
                enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  borderSide: BorderSide(color: unfocusedColor, width: 1.3),
                ),
            focusedBorder:
                focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  borderSide: BorderSide(
                    color: resolvedFocusedColor,
                    width: 1.8,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
