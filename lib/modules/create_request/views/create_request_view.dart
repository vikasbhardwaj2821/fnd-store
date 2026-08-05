import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../generated/asset_paths.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/country_bottomsheet.dart';
import '../../../utils/common/textform_field.dart';
import '../../../utils/utils.dart';
import '../controllers/create_request_controller.dart';

const _fieldHeight = 50.0;
const _fieldRadius = 12.0;

class CreateRequestView extends GetView<CreateRequestController> {
  const CreateRequestView({super.key});

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
                title: AppStrings.createRequest,
                titleColor: AppColors.black,
                backIconColor: AppColors.black,
                height: 64,
                showBottomBorder: false,
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenHorizontal,
                    4,
                    AppSpacing.screenHorizontal,
                    26,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const _SectionTitle(text: AppStrings.recipientDetail),
                      const SizedBox(height: 10),
                      _SectionCard(
                        children: [
                          _RequestField(
                            label: AppStrings.customerName,
                            hint: AppStrings.enter,
                            controller: controller.customerNameController,
                          ),
                          const SizedBox(height: 12),
                          _PhoneField(controller: controller),
                        ],
                      ),
                      const SizedBox(height: 22),
                      const _SectionTitle(text: AppStrings.packageDetails),
                      const SizedBox(height: 10),
                      _SectionCard(
                        children: [
                          _UploadField(controller: controller),
                          const SizedBox(height: 12),
                          _RequestField(
                            label: AppStrings.productImage,
                            hint: AppStrings.upload,
                            controller: controller.productController,
                          ),
                          const SizedBox(height: 12),
                          _RequestField(
                            label: AppStrings.pickupLocation,
                            hint: AppStrings.enterLocation,
                            controller: controller.pickupController,
                            suffix: _locationIcon,
                          ),
                          const SizedBox(height: 12),
                          _RequestField(
                            label: AppStrings.dropoffLocation,
                            hint: AppStrings.enterLocation,
                            controller: controller.dropoffController,
                            suffix: _locationIcon,
                          ),
                          const SizedBox(height: 12),
                          _RequestField(
                            label: AppStrings.date,
                            hint: AppStrings.select,
                            controller: controller.dateController,
                            readOnly: true,
                            onTap: () => controller.selectDate(context),
                            suffix: _arrowIcon,
                          ),
                          const SizedBox(height: 12),
                          _RequestField(
                            label: AppStrings.time,
                            hint: AppStrings.select,
                            controller: controller.timeController,
                            readOnly: true,
                            onTap: () => controller.selectTime(context),
                            suffix: _arrowIcon,
                          ),
                          const SizedBox(height: 12),
                          _RequestField(
                            label: AppStrings.packageInstructions,
                            hint: AppStrings.enterHere,
                            controller: controller.instructionsController,
                            height: 130,
                            maxLines: 6,
                            textAlignVertical: TextAlignVertical.top,
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      AppButton(
                        text: AppStrings.create,
                        onTap: controller.createRequest,
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

  static final Widget _locationIcon = Padding(
    padding: const EdgeInsetsDirectional.only(end: 14),
    child: SvgPicture.asset(
      Assets.locationNew,
      width: 12,
      height: 15,
      colorFilter: const ColorFilter.mode(
        AppColors.textSecondary,
        BlendMode.srcIn,
      ),
    ),
  );

  static const Widget _arrowIcon = Padding(
    padding: EdgeInsetsDirectional.only(end: 12),
    child: Icon(
      Icons.keyboard_arrow_down,
      color: AppColors.textSecondary,
      size: 18,
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => AppText(
    text: text,
    color: AppColors.black,
    textSize: 16,
    fontWeight: FontWeight.w600,
  );
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Column(children: children),
    );
  }
}

class _RequestField extends StatelessWidget {
  const _RequestField({
    required this.label,
    required this.hint,
    required this.controller,
    this.suffix,
    this.readOnly = false,
    this.onTap,
    this.height = _fieldHeight,
    this.maxLines = 1,
    this.textAlignVertical = TextAlignVertical.center,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget? suffix;
  final bool readOnly;
  final VoidCallback? onTap;
  final double height;
  final int maxLines;
  final TextAlignVertical textAlignVertical;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: label, color: AppColors.black, textSize: 11),
        const SizedBox(height: 5),
        SizedBox(
          height: height,
          child: CommonTextField(
            controller: controller,
            margin: EdgeInsets.zero,
            hintText: hint,
            readOnly: readOnly,
            onTap: onTap,
            suffixIcon: suffix,
            suffixIconConstraints: const BoxConstraints(minWidth: 36),
            maxLines: maxLines,
            borderRadius: _fieldRadius,
            borderColor: AppColors.fieldBorder,
            focusBorderColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            textAlignVertical: textAlignVertical,
            fontSize: 13,
            hintSize: 13,
          ),
        ),
      ],
    );
  }
}

class _UploadField extends StatelessWidget {
  const _UploadField({required this.controller});
  final CreateRequestController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.productImage,
          color: AppColors.black,
          textSize: 11,
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: controller.pickProductImage,
          child: Obx(
            () => Container(
              height: 122,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(_fieldRadius),
                border: Border.all(color: AppColors.fieldBorder),
              ),
              child: controller.productImage.value == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.profilePhotoBackground,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            Assets.uploadIcon,
                            colorFilter: const ColorFilter.mode(
                              AppColors.iconMuted,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        const AppText(
                          text: AppStrings.upload,
                          color: AppColors.textSecondary,
                          textSize: 12,
                        ),
                      ],
                    )
                  : Image.file(
                      controller.productImage.value!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller});
  final CreateRequestController controller;

  Future<void> _pickCountry(BuildContext context) async {
    final country = await showCountryPicker(
      context,
      selectedCountry: controller.selectedCountry.value,
    );
    if (country != null) controller.selectCountry(country);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.phoneNumber,
          color: AppColors.black,
          textSize: 11,
        ),
        const SizedBox(height: 5),
        Container(
          height: _fieldHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(_fieldRadius),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_fieldRadius),
            border: Border.all(color: AppColors.fieldBorder),
          ),
          child: Obx(
            () => Row(
              children: [
                Material(
                  color: AppColors.transparent,
                  child: InkWell(
                    onTap: () => _pickCountry(context),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 12,
                        end: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            text: controller.selectedCountry.value.flag ?? '',
                            textSize: 18,
                          ),
                          const SizedBox(width: 5),
                          AppText(
                            text:
                                '+${controller.selectedCountry.value.dialCode}',
                            color: AppColors.black,
                            textSize: 14,
                          ),
                          const SizedBox(width: 2),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.textSecondary,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                  child: VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: AppColors.fieldBorder,
                  ),
                ),
                Expanded(
                  child: CommonTextField(
                    controller: controller.phoneController,
                    margin: EdgeInsets.zero,
                    hintText: AppStrings.loginPhoneHint,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(
                        controller.selectedCountry.value.maxLength,
                      ),
                    ],
                    borderSide: false,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: AppColors.white,
                    borderRadius: 0,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    textAlignVertical: TextAlignVertical.center,
                    isDense: true,
                    expands: true,
                    fontSize: 14,
                    hintSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
