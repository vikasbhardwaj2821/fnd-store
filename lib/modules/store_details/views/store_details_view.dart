import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../generated/asset_paths.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/textform_field.dart';
import '../../../utils/utils.dart';
import '../controllers/store_details_controller.dart';

const double _storeFieldHeight = 52;
const double _storeFieldRadius = 12;

class StoreDetailsView extends GetView<StoreDetailsController> {
  const StoreDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final isEditMode = arguments is Map && arguments['editMode'] == true;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Utils.hideKeyboard(context),
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(
                title: AppStrings.storeDetails,
                titleColor: isEditMode ? AppColors.primary : AppColors.black,
                backIconColor: isEditMode ? AppColors.primary : AppColors.black,
                height: 64,
                backIconSize: 16,
                showBottomBorder: false,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    20,
                    AppSpacing.screenHorizontal,
                    24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _StoreImageUpload(controller: controller),
                      const SizedBox(height: 24),
                      _StoreField(
                        label: AppStrings.storeName,
                        hint: AppStrings.storeNameHint,
                        controller: controller.storeNameController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      _StoreField(
                        label: AppStrings.storeLocation,
                        hint: AppStrings.storeLocationHint,
                        controller: controller.storeLocationController,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                        text: isEditMode
                            ? AppStrings.editStoreDetails
                            : AppStrings.continueText,
                        onTap: isEditMode
                            ? controller.saveAndGoBack
                            : () => _showSuccessDialog(context),
                        showShadow: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    Utils.hideKeyboard(context);
    Get.dialog<void>(
      _AccountCreatedDialog(onContinue: controller.continueToHome),
      barrierDismissible: false,
      barrierColor: AppColors.black42,
    );
  }
}

class _StoreImageUpload extends StatelessWidget {
  const _StoreImageUpload({required this.controller});

  final StoreDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openPhotoPicker(context),
      child: Obx(
        () => CustomPaint(
          painter: _DashedRoundedBorderPainter(),
          child: SizedBox(
            width: double.infinity,
            height: 112,
            child: controller.storeImage.value == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.storeUpload,
                        width: 28,
                        height: 28,
                      ),
                      const SizedBox(height: 10),
                      const AppText(
                        text: AppStrings.uploadStoreImage,
                        color: AppColors.textSecondary,
                        textSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      controller.storeImage.value!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _DashedRoundedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      );
    final paint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 5), paint);
        distance += 9;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRoundedBorderPainter oldDelegate) => false;
}

class _AccountCreatedDialog extends StatelessWidget {
  const _AccountCreatedDialog({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 38, 28, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Assets.success, width: 92, height: 92),
              const SizedBox(height: 24),
              const AppText(
                text: AppStrings.accountCreated,
                color: AppColors.black,
                textSize: 20,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const AppText(
                text: AppStrings.accountCreatedDescription,
                color: AppColors.textDisabled,
                textSize: 15,
                fontWeight: FontWeight.w600,
                lineHeight: 1.20,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AppButton(
                text: AppStrings.continueText,
                onTap: onContinue,
                fontWeight: FontWeight.w700,
                showShadow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoreField extends StatelessWidget {
  const _StoreField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.textInputAction,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: label, color: AppColors.textDisabled, textSize: 11),
        const SizedBox(height: 5),
        SizedBox(
          height: _storeFieldHeight,
          child: CommonTextField(
            controller: controller,
            margin: EdgeInsets.zero,
            hintText: hint,
            textInputAction: textInputAction,
            borderRadius: _storeFieldRadius,
            fillColor: AppColors.white,
            borderColor: AppColors.fieldBorder,
            focusBorderColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            textAlignVertical: TextAlignVertical.center,
            isDense: false,
            fontSize: 14,
            hintSize: 14,
          ),
        ),
      ],
    );
  }
}
