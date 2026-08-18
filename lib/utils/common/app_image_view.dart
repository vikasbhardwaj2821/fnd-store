import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/asset_paths.dart';
import 'app_colors.dart';

class AppImageView extends StatelessWidget {
  const AppImageView({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.isCircle = false,
    this.backgroundColor = AppColors.profilePhotoBackground,
    this.placeholderPadding = const EdgeInsets.all(20),
    this.placeholderIconColor = AppColors.iconMuted,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final Color backgroundColor;
  final EdgeInsetsGeometry placeholderPadding;
  final Color placeholderIconColor;

  @override
  Widget build(BuildContext context) {
    final image = imageUrl.trim();
    final child = image.isEmpty
        ? _placeholder()
        : Image.network(
            image,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (_, _, _) => _placeholder(),
          );

    if (isCircle) {
      return ClipOval(child: SizedBox(width: width, height: height, child: child));
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: SizedBox(width: width, height: height, child: child),
      );
    }

    return SizedBox(width: width, height: height, child: child);
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      padding: placeholderPadding,
      child: SvgPicture.asset(
        Assets.person,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(
          placeholderIconColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
