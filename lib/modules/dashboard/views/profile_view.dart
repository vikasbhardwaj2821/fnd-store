import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/common/textform_field.dart';
import '../controllers/dashboard_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView> {
  final DashboardController _dashboardController =
      Get.find<DashboardController>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  Country _country = allCountries.firstWhere((country) => country.code == 'AE');
  late final Worker _userWorker;

  @override
  void initState() {
    super.initState();
    _setUserData();
    _userWorker = ever(_dashboardController.user, (_) => _setUserData());
  }

  void _setUserData() {
    final user = _dashboardController.user.value;
    if (user == null) return;
    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
    _emailController.text = user.email ?? '';
    _phoneController.text = user.phoneNumber ?? '';
    final dialCode = (user.countryCode ?? '').replaceFirst('+', '');
    final country = allCountries.firstWhereOrNull(
      (item) => item.dialCode == dialCode,
    );
    if (country != null && mounted) setState(() => _country = country);
  }

  @override
  void dispose() {
    _userWorker.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppHeader(
          title: AppStrings.profile,
          titleColor: AppColors.black,
          height: 64,
          showBottomBorder: true,
          centerTitle: true,
          showBackButton: false,
        ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                Obx(
                  () => _ProfilePhoto(
                    imageUrl: _dashboardController.profileImageUrl,
                  ),
                ),
                const SizedBox(height: 24),
                _ProfileField(
                  label: AppStrings.firstName,
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                _ProfileField(
                  label: AppStrings.lastName,
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                _ProfileField(
                  label: AppStrings.email,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                _ProfilePhoneField(
                  controller: _phoneController,
                  country: _country,
                ),
                const SizedBox(height: 26),
                AppButton(
                  text: AppStrings.updateInformation,
                  onTap: () => Get.toNamed<void>(AppRoutes.editProfile),
                  height: 52,
                  borderRadius: 12,
                  showShadow: false,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 86,
        height: 86,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: ClipOval(
                child: imageUrl.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        color: AppColors.profilePhotoBackground,
                        child: SvgPicture.asset(
                          Assets.person,
                          colorFilter: const ColorFilter.mode(
                            AppColors.iconMuted,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          padding: const EdgeInsets.all(20),
                          color: AppColors.profilePhotoBackground,
                          child: SvgPicture.asset(
                            Assets.person,
                            colorFilter: const ColorFilter.mode(
                              AppColors.iconMuted,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.textInputAction,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          color: AppColors.textDisabled,
          textSize: 12,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 52,
          child: CommonTextField(
            controller: controller,
            readOnly: true,
            margin: EdgeInsets.zero,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            borderRadius: 12,
            borderColor: AppColors.fieldBorder,
            focusBorderColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            textAlignVertical: TextAlignVertical.center,
            fontSize: 14,
            hintSize: 14,
          ),
        ),
      ],
    );
  }
}

class _ProfilePhoneField extends StatelessWidget {
  const _ProfilePhoneField({required this.controller, required this.country});

  final TextEditingController controller;
  final Country country;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: AppStrings.phoneNumber,
          color: AppColors.orLoginWith,
          textSize: 12,
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 52,
                padding: const EdgeInsetsDirectional.only(start: 10, end: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.fieldBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(text: country.flag ?? '', textSize: 18),
                    const SizedBox(width: 4),
                    AppText(
                      text: '+${country.dialCode}',
                      color: AppColors.black,
                      textSize: 13,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 52,
                child: CommonTextField(
                  controller: controller,
                  readOnly: true,
                  margin: EdgeInsets.zero,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(country.maxLength),
                  ],
                  borderRadius: 12,
                  borderColor: AppColors.fieldBorder,
                  focusBorderColor: AppColors.primary,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  fontSize: 14,
                  hintSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
