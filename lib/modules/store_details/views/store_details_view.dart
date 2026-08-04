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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => Utils.hideKeyboard(context),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(
                title: AppStrings.storeDetails,
                titleColor: AppColors.black,
                backIconColor: AppColors.black,
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
                      _StorePhoto(controller: controller),
                      const SizedBox(height: 54),
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
                        text: AppStrings.continueText,
                        onTap: controller.continueToStore,
                        height: 52,
                        borderRadius: 12,
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
}

class _StorePhoto extends StatelessWidget {
  const _StorePhoto({required this.controller});

  final StoreDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => controller.openPhotoPicker(context),
        child: Obx(
          () => Container(
            width: 92,
            height: 92,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.profilePhotoBackground,
            ),
            child: controller.storeImage.value == null
                ? Center(
                    child: Container(
                      width: 25,
                      height: 25,
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: SvgPicture.asset(
                        Assets.cameraNew,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                : Image.file(controller.storeImage.value!, fit: BoxFit.cover),
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
