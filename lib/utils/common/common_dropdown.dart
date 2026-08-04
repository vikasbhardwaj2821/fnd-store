import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class CommonDropdown<T> extends StatelessWidget {
  const CommonDropdown({
    super.key,
    required this.options,
    required this.onSelected,
    this.value,
    this.hint,
    this.itemLabel,
    this.fillColor,
    this.borderRadius = 8,
  });

  final List<T> options;
  final T? value;
  final ValueChanged<T?> onSelected;
  final String? hint;
  final String Function(T option)? itemLabel;
  final Color? fillColor;
  final double borderRadius;

  String _label(T option) => (itemLabel?.call(option) ?? '$option').tr;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.textPrimary,
        size: 22,
      ),
      dropdownColor: AppColors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontFamily: 'PlusJakartaSans',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hint: Text(
        hint?.tr ?? '',
        style: const TextStyle(
          color: AppColors.hintText,
          fontFamily: 'PlusJakartaSans',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: fillColor ?? AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 17,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      items: options
          .map(
            (option) =>
                DropdownMenuItem<T>(value: option, child: Text(_label(option))),
          )
          .toList(),
      onChanged: onSelected,
    );
  }
}
