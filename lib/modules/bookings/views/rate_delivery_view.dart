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
import '../../../utils/common/textform_field.dart';

class RateDeliveryView extends StatefulWidget {
  const RateDeliveryView({super.key});

  @override
  State<RateDeliveryView> createState() => _RateDeliveryViewState();
}

class _RateDeliveryViewState extends State<RateDeliveryView> {
  static const _tags = [
    AppStrings.onTime,
    AppStrings.friendlyDriver,
    AppStrings.packageSafe,
    AppStrings.greatService,
    AppStrings.goodUpdates,
  ];

  final _reviewController = TextEditingController();
  final Set<String> _selectedTags = {};
  int _rating = 0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: AppStrings.rateDelivery,
              centerTitle: true,
              height: 56,
            ),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _OrderCard(),
                    const SizedBox(height: 18),
                    const Center(
                      child: CircleAvatar(
                        radius: 31,
                        backgroundImage: AssetImage(Assets.driverPhoto),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const AppText(
                      text: AppStrings.howWasDelivery,
                      color: AppColors.black,
                      textSize: 17,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    const AppText(
                      text: AppStrings.ratingDescription,
                      color: AppColors.textSecondary,
                      textSize: 11,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final value = index + 1;
                        return GestureDetector(
                          onTap: () => setState(() => _rating = value),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: SvgPicture.asset(
                              value <= _rating
                                  ? Assets.starColored
                                  : Assets.starUncolored,
                              width: 28,
                              height: 28,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 22),
                    const _SectionTitle(AppStrings.whatWentWell),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _tags.map((tag) {
                        final selected = _selectedTags.contains(tag);
                        return GestureDetector(
                          onTap: () => setState(() {
                            selected
                                ? _selectedTags.remove(tag)
                                : _selectedTags.add(tag);
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.softPrimary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                            child: AppText(
                              text: tag,
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              textSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 18),
                    const _SectionTitle(AppStrings.tellMoreExperience),
                    const SizedBox(height: 10),
                    CommonTextField(
                      controller: _reviewController,
                      hintText: AppStrings.reviewHint,
                      minLines: 5,
                      maxLines: 5,
                      margin: EdgeInsets.zero,
                      borderRadius: 8,
                      fontSize: 12,
                      hintSize: 12,
                      contentPadding: const EdgeInsets.all(14),
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
              child: AppButton(
                text: AppStrings.submitReview,
                onTap: () => Get.offAllNamed<void>(AppRoutes.dashboard),
                height: 48,
                borderRadius: 8,
                textSize: 13,
                showShadow: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(child: _Info(AppStrings.orderId, '#FND-8821')),
              _Info(AppStrings.deliveryDate, AppStrings.ratingDeliveryDate),
            ],
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          color: AppColors.textSecondary,
          textSize: 10,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 4),
        AppText(
          text: value,
          color: AppColors.primary,
          textSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: text,
      color: AppColors.black,
      textSize: 13,
      fontWeight: FontWeight.w600,
    );
  }
}
