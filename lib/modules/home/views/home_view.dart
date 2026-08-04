import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../bookings/views/bookings_view.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/booking_card.dart';
import '../../../utils/common/countries.dart';
import '../../../utils/common/country_bottomsheet.dart';
import '../../../utils/common/textform_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const _pageTitles = [
    AppStrings.appName,
    AppStrings.bookings,
    '',
    AppStrings.profile,
    AppStrings.settings,
  ];

  void _selectTab(int index) {
    if (index == 2) return;
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(bottom: false, child: _buildPage()),
      bottomNavigationBar: _DashboardNavigation(
        selectedIndex: _selectedIndex,
        onSelected: _selectTab,
        onCreate: () => Get.toNamed<void>(AppRoutes.createRequest),
      ),
    );
  }

  Widget _buildPage() {
    if (_selectedIndex == 0) {
      return const _HomePage();
    }
    if (_selectedIndex == 1) {
      return const BookingsView();
    }
    if (_selectedIndex == 3) {
      return const _ProfilePage();
    }
    if (_selectedIndex == 4) {
      return const _SettingsPage();
    }
    return Center(
      child: AppText(
        text: _pageTitles[_selectedIndex],
        color: AppColors.black,
        textSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _HomeHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _DeliveredSummary(),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Expanded(
                      child: AppText(
                        text: AppStrings.todaysBookings,
                        color: AppColors.black,
                        textSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const AppText(
                        text: AppStrings.viewAll,
                        color: AppColors.primary,
                        textSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const BookingCard(
                  type: BookingCardType.ongoing,
                  orderNumber: '#FND-8821',
                  status: AppStrings.orderPickedUp,
                  statusColor: AppColors.bookingStatusOrange,
                  pickupAddress: AppStrings.downtownHub,
                  dropoffAddress: AppStrings.westsideTerminal,
                  time: AppStrings.today1430,
                ),
                const SizedBox(height: 12),
                const BookingCard(
                  type: BookingCardType.ongoing,
                  orderNumber: '#FND-9042',
                  status: AppStrings.driverOnWay,
                  statusColor: AppColors.bookingStatusGrey,
                  pickupAddress: AppStrings.eastPort,
                  dropoffAddress: AppStrings.centralStorage,
                  time: AppStrings.today1615,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.fieldBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              color: AppColors.profilePhotoBackground,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              Assets.person,
              colorFilter: const ColorFilter.mode(
                AppColors.iconMuted,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: AppStrings.homeGreeting,
                  color: AppColors.black,
                  textSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 2),
                AppText(
                  text: AppStrings.happyCollecting,
                  color: AppColors.textSecondary,
                  textSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Get.toNamed<void>(AppRoutes.notifications),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    Assets.notificationIcon,
                    width: 18,
                    height: 20,
                  ),
                  PositionedDirectional(
                    end: -1,
                    top: -1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.countdown,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveredSummary extends StatelessWidget {
  const _DeliveredSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 8, 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppStrings.totalDelivered,
                color: AppColors.black,
                textSize: 13,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 3),
              AppText(
                text: '1,284',
                color: AppColors.primary,
                textSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          const Icon(
            Icons.local_shipping_outlined,
            size: 60,
            color: AppColors.black42,
          ),
        ],
      ),
    );
  }
}

// TODO: Remove after the remaining legacy home layout is fully migrated.
// ignore: unused_element
class _BookingCard extends StatelessWidget {
  const _BookingCard({
    required this.orderNumber,
    required this.status,
    required this.statusColor,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.time,
  });

  final String orderNumber;
  final String status;
  final Color statusColor;
  final String pickupAddress;
  final String dropoffAddress;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      text: AppStrings.orderId,
                      color: AppColors.textSecondary,
                      textSize: 12,
                    ),
                    const SizedBox(height: 2),
                    AppText(
                      text: orderNumber,
                      color: AppColors.primary,
                      textSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 90, minHeight: 28),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: AppText(
                    text: status,
                    color: AppColors.black42,
                    textSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Stack(
            children: [
              PositionedDirectional(
                start: 11,
                top: 12,
                bottom: 20,
                child: const SizedBox(
                  width: 4,
                  child: CustomPaint(painter: _RouteDashesPainter()),
                ),
              ),
              Column(
                children: [
                  _LocationRow(
                    isPickup: true,
                    label: AppStrings.pickup,
                    address: pickupAddress,
                  ),
                  const SizedBox(height: 8),
                  _LocationRow(
                    isPickup: false,
                    label: AppStrings.dropoff,
                    address: dropoffAddress,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),
          Row(
            children: [
              SvgPicture.asset(
                Assets.calendarIcon,
                width: 18,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: AppText(
                  text: time,
                  color: AppColors.orLoginWith,
                  fontWeight: FontWeight.w600,
                  textSize: 12,
                ),
              ),
              AppButton(
                text: AppStrings.track,
                onTap: () {},
                width: 84,
                height: 38,
                borderRadius: 8,
                textSize: 13,
                padding: EdgeInsets.zero,
                showShadow: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RouteDashesPainter extends CustomPainter {
  const _RouteDashesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.routeConnector
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.square;

    const dashHeight = 7.0;
    const dashGap = 6.0;
    for (double y = 0; y < size.height; y += dashHeight + dashGap) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, (y + dashHeight).clamp(0, size.height)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_RouteDashesPainter oldDelegate) => false;
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({
    required this.isPickup,
    required this.label,
    required this.address,
  });

  final bool isPickup;
  final String label;
  final String address;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: isPickup
                  ? AppColors.pickupMarkerBackground
                  : AppColors.dropoffMarkerBackground,
              shape: BoxShape.circle,
            ),
            child: isPickup
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      Positioned(
                        top: 7,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  )
                : const Icon(
                    Icons.local_shipping,
                    color: AppColors.dropoffMarker,
                    size: 18,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: label,
                  color: AppColors.orLoginWith,
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 3),
                AppText(
                  text: address,
                  color: AppColors.black,
                  textSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePage extends StatefulWidget {
  const _ProfilePage();

  @override
  State<_ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<_ProfilePage> {
  final _firstNameController = TextEditingController(text: 'Mily');
  final _lastNameController = TextEditingController(text: 'Deo');
  final _emailController = TextEditingController(text: 'milydeo123@gmail.com');
  final _phoneController = TextEditingController(text: '11234567890');
  Country _country = allCountries.firstWhere((country) => country.code == 'AE');

  Future<void> _pickCountry() async {
    final country = await showCountryPicker(context, selectedCountry: _country);
    if (country != null) {
      setState(() => _country = country);
    }
  }

  @override
  void dispose() {
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
          showBottomBorder: false,
          centerTitle: true,
          showBackButton: false,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _ProfilePhoto(),
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
                  onCountryTap: _pickCountry,
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
  const _ProfilePhoto();

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
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.profilePhotoBackground,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  Assets.person,
                  colorFilter: const ColorFilter.mode(
                    AppColors.iconMuted,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              end: -2,
              bottom: 3,
              child: Container(
                width: 28,
                height: 28,
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  Assets.cameraNew,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
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
        AppText(text: label, color: AppColors.textDisabled, textSize: 11),
        const SizedBox(height: 5),
        SizedBox(
          height: 52,
          child: CommonTextField(
            controller: controller,
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
  const _ProfilePhoneField({
    required this.controller,
    required this.country,
    required this.onCountryTap,
  });

  final TextEditingController controller;
  final Country country;
  final VoidCallback onCountryTap;

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
              child: InkWell(
                onTap: onCountryTap,
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
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 52,
                child: CommonTextField(
                  controller: controller,
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

class _SettingsPage extends StatefulWidget {
  const _SettingsPage();

  @override
  State<_SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<_SettingsPage> {
  bool _notificationsEnabled = true;

  void _showAccountActionDialog({required bool isDelete}) {
    Get.dialog<void>(
      _AccountActionDialog(
        isDelete: isDelete,
        onConfirm: () => Get.offAllNamed<void>(AppRoutes.login),
      ),
      barrierDismissible: false,
      barrierColor: AppColors.black42,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.pageBackground,
      child: Column(
        children: [
          const AppHeader(
            title: AppStrings.settings,
            titleColor: AppColors.primary,
            height: 64,
            showBottomBorder: false,
            centerTitle: true,
            showBackButton: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 84,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppStrings.appSettings,
                          color: AppColors.disabledButtonText,
                          textSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 3),
                        AppText(
                          text: AppStrings.appSettingsDescription,
                          color: AppColors.white70,
                          textSize: 11,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const _SettingsSectionLabel(text: AppStrings.preferences),
                  const SizedBox(height: 7),
                  _SettingsCard(
                    children: [
                      _SettingsRow(
                        icon: Assets.notificationIcon,
                        label: AppStrings.notifications,
                        trailing: Transform.scale(
                          scale: 0.82,
                          child: Switch(
                            value: _notificationsEnabled,
                            onChanged: (value) =>
                                setState(() => _notificationsEnabled = value),
                            activeTrackColor: AppColors.primary,
                            activeThumbColor: AppColors.white,
                            inactiveTrackColor: AppColors.border,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const _SettingsSectionLabel(text: AppStrings.legalAndSupport),
                  const SizedBox(height: 7),
                  _SettingsCard(
                    children: [
                      _SettingsRow(
                        icon: Assets.storeDetails,
                        label: AppStrings.storeDetails,
                        showArrow: true,
                        onTap: () => Get.toNamed<void>(
                          AppRoutes.storeDetails,
                          arguments: const {'editMode': true},
                        ),
                      ),
                      _SettingsRow(
                        icon: Assets.changeLanguage,
                        label: AppStrings.changeLanguage,
                        showArrow: true,
                        onTap: () =>
                            Get.toNamed<void>(AppRoutes.changeLanguage),
                      ),
                      _SettingsRow(
                        icon: Assets.settingsTerms,
                        label: AppStrings.termsAndConditions,
                        showArrow: true,
                        onTap: () =>
                            Get.toNamed<void>(AppRoutes.termsAndConditions),
                      ),
                      _SettingsRow(
                        icon: Assets.privacyPolicy,
                        label: AppStrings.privacyPolicies,
                        showArrow: true,
                        onTap: () => Get.toNamed<void>(AppRoutes.privacyPolicy),
                      ),
                      _SettingsRow(
                        icon: Assets.contactUs,
                        label: AppStrings.contactUs,
                        showArrow: true,
                        showDivider: false,
                        onTap: () => Get.toNamed<void>(AppRoutes.contactUs),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const _SettingsSectionLabel(text: AppStrings.accountActions),
                  const SizedBox(height: 7),
                  _SettingsCard(
                    children: [
                      _SettingsRow(
                        icon: Assets.settingsLogout,
                        label: AppStrings.logout,
                        onTap: () => _showAccountActionDialog(isDelete: false),
                      ),
                      _SettingsRow(
                        icon: Assets.deleteAccount,
                        label: AppStrings.deleteAccount,
                        color: AppColors.countdown,
                        showDivider: false,
                        onTap: () => _showAccountActionDialog(isDelete: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 34),
                  const Center(
                    child: AppText(
                      text: AppStrings.appVersion,
                      color: AppColors.textSecondary,
                      textSize: 10,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: AppText(
                      text: AppStrings.managedBy,
                      color: AppColors.textDisabled,
                      textSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountActionDialog extends StatelessWidget {
  const _AccountActionDialog({required this.isDelete, required this.onConfirm});

  final bool isDelete;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final accent = isDelete ? AppColors.countdown : AppColors.primary;
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDelete ? AppColors.surface : AppColors.softPrimary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  isDelete ? Assets.deleteAccount : Assets.settingsLogout,
                  colorFilter: ColorFilter.mode(accent, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 12),
              AppText(
                text: isDelete
                    ? AppStrings.deleteConfirmation
                    : AppStrings.logoutConfirmation,
                color: AppColors.black,
                textSize: 18,
                fontWeight: FontWeight.w800,
                lineHeight: 1.3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              AppText(
                text: isDelete
                    ? AppStrings.deleteDescription
                    : AppStrings.logoutDescription,
                color: AppColors.textSecondary,
                textSize: 12,
                lineHeight: 1.35,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              AppButton(
                text: isDelete ? AppStrings.yesDelete : AppStrings.yesLogout,
                onTap: onConfirm,
                height: 50,
                borderRadius: 8,
                textSize: 14,
                backgroundColor: accent,
                showShadow: false,
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: Get.back<void>,
                child: AppText(
                  text: isDelete
                      ? AppStrings.keepAccount
                      : AppStrings.staySignedIn,
                  color: AppColors.primary,
                  textSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSectionLabel extends StatelessWidget {
  const _SettingsSectionLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => AppText(
    text: text,
    color: AppColors.textSecondary,
    textSize: 10,
    fontWeight: FontWeight.w500,
    capitalise: true,
  );
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    this.trailing,
    this.showArrow = false,
    this.showDivider = true,
    this.color,
    this.onTap,
  });

  final String icon;
  final String label;
  final Widget? trailing;
  final bool showArrow;
  final bool showDivider;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? AppColors.black;
    return Container(
      height: 51,
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.fieldBorder))
            : null,
      ),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 17,
                height: 17,
                colorFilter: color == null
                    ? null
                    : ColorFilter.mode(color!, BlendMode.srcIn),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppText(
                  text: label,
                  color: foreground,
                  textSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (trailing != null)
                trailing!
              else if (showArrow)
                SvgPicture.asset(Assets.settingsArrow, width: 8, height: 13),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardNavigation extends StatelessWidget {
  const _DashboardNavigation({
    required this.selectedIndex,
    required this.onSelected,
    required this.onCreate,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonShadow,
            blurRadius: 18,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 76,
          child: Row(
            children: [
              Expanded(
                child: _NavigationItem(
                  label: AppStrings.home,
                  asset: Assets.homeIcon,
                  selected: selectedIndex == 0,
                  onTap: () => onSelected(0),
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  label: AppStrings.bookings,
                  asset: selectedIndex == 1
                      ? Assets.bookingColored
                      : Assets.bookingUncolored,
                  selected: selectedIndex == 1,
                  preserveAssetColor: true,
                  onTap: () => onSelected(1),
                ),
              ),
              Expanded(
                child: Center(
                  child: Material(
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    elevation: 8,
                    shadowColor: AppColors.black42,
                    child: InkWell(
                      onTap: onCreate,
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 58,
                        height: 58,
                        child: Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 31,
                          weight: 300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  label: AppStrings.profile,
                  asset: Assets.profileIcon,
                  selected: selectedIndex == 3,
                  onTap: () => onSelected(3),
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  label: AppStrings.settings,
                  asset: Assets.settingsIcon,
                  selected: selectedIndex == 4,
                  onTap: () => onSelected(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.label,
    required this.asset,
    required this.selected,
    required this.onTap,
    this.preserveAssetColor = false,
  });

  final String label;
  final String asset;
  final bool selected;
  final VoidCallback onTap;
  final bool preserveAssetColor;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.orLoginWith;
    return InkWell(
      onTap: onTap,
      child: Semantics(
        selected: selected,
        button: true,
        label: label,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: 20,
              height: 20,
              colorFilter: preserveAssetColor
                  ? null
                  : ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 5),
            AppText(
              text: label,
              color: color,
              textSize: 10,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
