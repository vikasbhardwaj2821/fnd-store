import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final isCompleted = arguments is Map && arguments['completed'] == true;
    final fromTrackDelivery =
        arguments is Map && arguments['fromTrackDelivery'] == true;
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: AppStrings.bookingDetails,
              centerTitle: true,
              height: 56,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
                children: [
                  _StatusCard(isCompleted: isCompleted),
                  const SizedBox(height: 16),
                  const _SectionTitle(AppStrings.recipientDetailTitle),
                  const SizedBox(height: 8),
                  const _RecipientCard(),
                  const SizedBox(height: 16),
                  const _SectionTitle(AppStrings.packageDetails),
                  const SizedBox(height: 8),
                  const _PackageCard(),
                  const SizedBox(height: 16),
                  const _SectionTitle(AppStrings.driverDetails),
                  const SizedBox(height: 8),
                  _DriverCard(showCallButton: !isCompleted),
                ],
              ),
            ),
            if (!isCompleted)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: AppButton(
                  text: AppStrings.track,
                  onTap: () => _openTracking(fromTrackDelivery),
                  height: 50,
                  borderRadius: 8,
                  showShadow: false,
                  icon1: Assets.trackIcon,
                  widthIcon1: 18,
                  heightIcon1: 18,
                  iconColor: AppColors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  static void _emptyAction() {}

  static void _openTracking(bool fromTrackDelivery) {
    if (fromTrackDelivery) {
      Get.back<void>();
      return;
    }
    Get.toNamed<void>(AppRoutes.trackDelivery);
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
      textSize: 15,
      fontWeight: FontWeight.w600,
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.isCompleted});
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.positive : AppColors.primary,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StatusValue(
            AppStrings.orderStatus,
            isCompleted ? AppStrings.delivered : AppStrings.inTransit,
          ),
          const _StatusValue(AppStrings.orderId, '#FND-8821', alignEnd: true),
        ],
      ),
    );
  }
}

class _StatusValue extends StatelessWidget {
  const _StatusValue(this.label, this.value, {this.alignEnd = false});
  final String label;
  final String value;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          color: AppColors.white70,
          textSize: 11,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 2),
        AppText(
          text: value,
          color: AppColors.white,
          textSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}

class _RecipientCard extends StatelessWidget {
  const _RecipientCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: const [
          _LabeledValue(AppStrings.customerName, AppStrings.customerNameValue),
          Divider(color: AppColors.border),
          _LabeledValue(AppStrings.phoneNumber, AppStrings.customerPhoneValue),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  const _PackageCard();

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: AppStrings.packagePhoto,
            color: AppColors.textSecondary,
            textSize: 11,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 7),
          Container(
            height: 165,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(9),
            ),
            child: CustomPaint(
              foregroundPainter: const _DashedRoundedBorderPainter(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.asset(
                  Assets.productImage,
                  width: double.infinity,
                  height: 165,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Stack(
            children: [
              const PositionedDirectional(
                start: 7,
                top: 15,
                bottom: 15,
                child: SizedBox(
                  width: 2,
                  child: ColoredBox(color: AppColors.routeConnector),
                ),
              ),
              const Column(
                children: [
                  _RouteValue(
                    icon: Icons.radio_button_checked,
                    iconColor: AppColors.primary,
                    label: AppStrings.pickupLocation,
                    value: AppStrings.bookingPickupAddress,
                  ),
                  SizedBox(height: 10),
                  _RouteValue(
                    icon: Icons.location_on_outlined,
                    iconColor: AppColors.countdown,
                    label: AppStrings.dropoffLocation,
                    value: AppStrings.bookingDropoffAddress,
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 24, color: AppColors.border),
          const Row(
            children: [
              Expanded(
                child: _IconValue(
                  icon: Icons.calendar_today_outlined,
                  label: AppStrings.date,
                  value: AppStrings.bookingDateValue,
                ),
              ),
              Expanded(
                child: _IconValue(
                  icon: Icons.access_time,
                  label: AppStrings.time,
                  value: AppStrings.bookingTimeValue,
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: AppColors.border),
          const _LabeledValue(
            AppStrings.packageInstructions,
            AppStrings.packageInstructionsValue,
          ),
          const Divider(height: 24, color: AppColors.border),
          const AppText(
            text: AppStrings.deliveryCharges,
            color: AppColors.textSecondary,
            textSize: 11,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 5),
          const Row(
            children: [
              Icon(
                Icons.payments_outlined,
                size: 15,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 6),
              Expanded(
                child: AppText(
                  text: AppStrings.delivery,
                  color: AppColors.black,
                  textSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppText(
                text: AppStrings.deliveryPrice,
                color: AppColors.primary,
                textSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DriverCard extends StatelessWidget {
  const _DriverCard({required this.showCallButton});
  final bool showCallButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Get.toNamed<void>(AppRoutes.driverReviews),
      child: _CardShell(
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(Assets.driverPhoto),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: AppStrings.driverName,
                        color: AppColors.black,
                        textSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      AppText(
                        text: AppStrings.driverVehicle,
                        color: AppColors.textSecondary,
                        textSize: 11,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: AppColors.express, size: 13),
                      SizedBox(width: 3),
                      AppText(
                        text: '4.9',
                        color: AppColors.black,
                        textSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showCallButton) ...[
              const SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: AppButton(
                  text: AppStrings.callDriver,
                  onTap: BookingDetailsView._emptyAction,
                  width: 150,
                  height: 40,
                  borderRadius: 8,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textSize: 13,
                  showShadow: false,
                  icon1: Assets.callIcon,
                  widthIcon1: 17,
                  heightIcon1: 17,
                  iconColor: AppColors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.fieldBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.buttonShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _LabeledValue extends StatelessWidget {
  const _LabeledValue(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: label,
            color: AppColors.textSecondary,
            textSize: 11,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 4),
          AppText(
            text: value,
            color: AppColors.black,
            textSize: 13,
            fontWeight: FontWeight.w500,
            lineHeight: 1.35,
          ),
        ],
      ),
    );
  }
}

class _RouteValue extends StatelessWidget {
  const _RouteValue({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          color: AppColors.white,
          alignment: Alignment.center,
          child: Icon(icon, color: iconColor, size: 17),
        ),
        const SizedBox(width: 8),
        Expanded(child: _LabeledValue(label, value)),
      ],
    );
  }
}

class _IconValue extends StatelessWidget {
  const _IconValue({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
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
          textSize: 11,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, size: 15, color: AppColors.textSecondary),
            const SizedBox(width: 5),
            Expanded(
              child: AppText(
                text: value,
                color: AppColors.black,
                textSize: 12,
                fontWeight: FontWeight.w500,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DashedRoundedBorderPainter extends CustomPainter {
  const _DashedRoundedBorderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(9)),
      );
    final paint = Paint()
      ..color = AppColors.textSecondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + 6).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += 10;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRoundedBorderPainter oldDelegate) => false;
}
