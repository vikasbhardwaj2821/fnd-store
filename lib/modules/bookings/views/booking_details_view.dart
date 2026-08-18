import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../app/routes/app_routes.dart';
import '../../../data/network/api_constant.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_image_view.dart';
import '../../../utils/common/app_text.dart';
import '../controllers/booking_details_controller.dart';

class BookingDetailsView extends GetView<BookingDetailsController> {
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
        child: Obx(
          () {
            final track = controller.trackData.value?.request;
            final isPending = track?.status == 0;
            final showDriverSection = !isPending;
            return Column(
              children: [
                const AppHeader(
                  title: AppStrings.bookingDetails,
                  centerTitle: true,
                  height: 56,
                ),
                Expanded(
                  child: controller.isLoading.value || track == null
                      ? const _BookingDetailsShimmer()
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
                          children: [
                            _StatusCard(
                              isCompleted: isCompleted,
                              orderNumber: track.orderNumber ?? '',
                              statusText: _statusText(track.status),
                            ),
                            const SizedBox(height: 16),
                            const _SectionTitle(AppStrings.recipientDetailTitle),
                            const SizedBox(height: 8),
                            _RecipientCard(
                              name: track.recipientName ?? '',
                              phone: track.recipientPhone ?? '',
                            ),
                            const SizedBox(height: 16),
                            const _SectionTitle(AppStrings.packageDetails),
                            const SizedBox(height: 8),
                            _PackageCard(track: track),
                            const SizedBox(height: 16),
                            if (showDriverSection) ...[
                              const _SectionTitle(AppStrings.driverDetails),
                              const SizedBox(height: 8),
                              _DriverCard(
                                showCallButton: !isCompleted,
                                driverName:
                                    track.driver?['name']?.toString() ??
                                    'Driver',
                                driverStats: controller.trackData.value
                                        ?.driverDeliveryCount
                                        ?.toString()
                                        .isNotEmpty ==
                                    true
                                    ? '${controller.trackData.value?.driverDeliveryCount} Deliveries'
                                    : '0 Deliveries',
                              ),
                            ],
                          ],
                        ),
                ),
                if (showDriverSection && !isCompleted && track != null)
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
            );
          },
        ),
      ),
    );
  }

  static String _statusText(int? status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Accepted';
      case 2:
        return 'Order picked up';
      case 3:
        return 'Driver on the way';
      case 4:
        return AppStrings.delivered;
      case 5:
        return 'Cancelled';
      default:
        return AppStrings.inTransit;
    }
  }

  static void _openTracking(bool fromTrackDelivery) {
    if (fromTrackDelivery) {
      Get.back<void>();
      return;
    }
    Get.toNamed<void>(AppRoutes.trackDelivery);
  }
}

class _BookingDetailsShimmer extends StatelessWidget {
  const _BookingDetailsShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
      children: [
        _ShimmerBlock(height: 54, radius: 9),
        const SizedBox(height: 16),
        const _ShimmerLine(widthFactor: 0.42),
        const SizedBox(height: 8),
        _ShimmerBlock(height: 74, radius: 9),
        const SizedBox(height: 16),
        const _ShimmerLine(widthFactor: 0.34),
        const SizedBox(height: 8),
        _ShimmerBlock(height: 240, radius: 9),
        const SizedBox(height: 16),
        const _ShimmerLine(widthFactor: 0.34),
        const SizedBox(height: 8),
        _ShimmerBlock(height: 110, radius: 9),
      ],
    );
  }
}

class _ShimmerLine extends StatelessWidget {
  const _ShimmerLine({required this.widthFactor});
  final double widthFactor;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth * widthFactor,
        height: 12,
        decoration: BoxDecoration(
          color: AppColors.border.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _ShimmerBlock extends StatelessWidget {
  const _ShimmerBlock({required this.height, required this.radius});
  final double height;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.fieldBorder),
      ),
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
      textSize: 15,
      fontWeight: FontWeight.w600,
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.isCompleted,
    required this.orderNumber,
    required this.statusText,
  });
  final bool isCompleted;
  final String orderNumber;
  final String statusText;

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
          _StatusValue(AppStrings.orderStatus, statusText),
          _StatusValue(AppStrings.orderId, orderNumber, alignEnd: true),
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
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
  const _RecipientCard({required this.name, required this.phone});
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: [
          _LabeledValue(AppStrings.customerName, name),
          const Divider(color: AppColors.border),
          _LabeledValue(AppStrings.phoneNumber, phone),
        ],
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  const _PackageCard({required this.track});

  final dynamic track;

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
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
              child: AppImageView(
                imageUrl: ApiConstants.mediaUrl(track.packageImage ?? ''),
                width: double.infinity,
                height: 165,
            ),
          ),
          const SizedBox(height: 14),
          _RouteValue(
            icon: Icons.radio_button_checked,
            iconColor: AppColors.primary,
            label: AppStrings.pickupLocation,
            value: track.pickupLocation ?? '',
          ),
          const SizedBox(height: 10),
          _RouteValue(
            icon: Icons.location_on_outlined,
            iconColor: AppColors.countdown,
            label: AppStrings.dropoffLocation,
            value: track.dropoffLocation ?? '',
          ),
          const Divider(height: 24, color: AppColors.border),
          Row(
            children: [
              Expanded(
                child: _IconValue(
                  icon: Icons.calendar_today_outlined,
                  label: AppStrings.date,
                  value: track.scheduledDate ?? '',
                ),
              ),
              Expanded(
              child: _IconValue(
                  icon: Icons.access_time,
                  label: AppStrings.time,
                  value: _time12Hour(track.scheduledTimeFrom),
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: AppColors.border),
          _LabeledValue(
            AppStrings.packageInstructions,
            track.packageInstructions ?? '',
          ),
          const Divider(height: 24, color: AppColors.border),
          const AppText(
            text: AppStrings.deliveryCharges,
            color: AppColors.textSecondary,
            textSize: 11,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.payments_outlined,
                size: 15,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              const Expanded(
                child: AppText(
                  text: AppStrings.delivery,
                  color: AppColors.black,
                  textSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppText(
                text: '\$${track.price ?? 0}',
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

  static String _time12Hour(String? rawTime) {
    if (rawTime == null || rawTime.isEmpty) return '';
    try {
      final parsed = DateFormat('HH:mm:ss').parse(rawTime);
      return DateFormat('hh:mm a').format(parsed);
    } catch (_) {
      return rawTime;
    }
  }
}

class _DriverCard extends StatelessWidget {
  const _DriverCard({
    required this.showCallButton,
    required this.driverName,
    required this.driverStats,
  });

  final bool showCallButton;
  final String driverName;
  final String driverStats;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(Assets.driverPhoto),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: driverName,
                      color: AppColors.black,
                      textSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    AppText(
                      text: driverStats,
                      color: AppColors.textSecondary,
                      textSize: 11,
                      fontWeight: FontWeight.w500,
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
                onTap: () {},
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
