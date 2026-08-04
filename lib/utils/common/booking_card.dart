import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/asset_paths.dart';
import '../app_strings.dart';
import 'app_button.dart';
import 'app_colors.dart';
import 'app_text.dart';

enum BookingCardType { ongoing, upcoming, completed }

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.type,
    required this.orderNumber,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.time,
    this.status,
    this.statusColor,
    this.actionText = AppStrings.track,
    this.schedule,
    this.onAction,
    this.onCancel,
  });

  final BookingCardType type;
  final String orderNumber;
  final String pickupAddress;
  final String dropoffAddress;
  final String time;
  final String? status;
  final Color? statusColor;
  final String actionText;
  final String? schedule;
  final VoidCallback? onAction;
  final VoidCallback? onCancel;

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
          type == BookingCardType.upcoming
              ? _UpcomingHeader(
                  orderNumber: orderNumber,
                  schedule: schedule ?? time,
                )
              : _StandardHeader(
                  orderNumber: orderNumber,
                  status: status,
                  statusColor: statusColor,
                  showStatusIcon: type == BookingCardType.completed,
                ),
          const SizedBox(height: 14),
          _BookingRoute(
            pickupAddress: pickupAddress,
            dropoffAddress: dropoffAddress,
            upcoming: type == BookingCardType.upcoming,
          ),
          const SizedBox(height: 15),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),
          if (type == BookingCardType.upcoming)
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppButton(
                    text: AppStrings.cancel,
                    onTap: onCancel ?? () {},
                    height: 45,

                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primary,
                    borderColor: AppColors.primary,
                    borderWidth: 1,
                    showShadow: false,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: AppButton(
                    text: AppStrings.details,
                    onTap: onAction ?? () {},
                    height: 45,

                    padding: EdgeInsets.zero,
                    showShadow: false,
                  ),
                ),
              ],
            )
          else
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
                if (type == BookingCardType.ongoing)
                  AppButton(
                    text: actionText,
                    onTap: onAction ?? () {},
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

class _StandardHeader extends StatelessWidget {
  const _StandardHeader({
    required this.orderNumber,
    this.status,
    this.statusColor,
    this.showStatusIcon = false,
  });

  final String orderNumber;
  final String? status;
  final Color? statusColor;
  final bool showStatusIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        if (status != null)
          Container(
            constraints: const BoxConstraints(minWidth: 90, minHeight: 28),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: statusColor ?? AppColors.bookingStatusGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showStatusIcon) ...[
                  const Icon(
                    Icons.check_circle,
                    size: 12,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 3),
                ],
                AppText(
                  text: status!,
                  color: AppColors.black,
                  textSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _UpcomingHeader extends StatelessWidget {
  const _UpcomingHeader({required this.orderNumber, required this.schedule});
  final String orderNumber;
  final String schedule;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.softPrimary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: SvgPicture.asset(Assets.bookingIcon),
        ),
        const SizedBox(width: 8),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const AppText(
              text: AppStrings.schedule,
              color: AppColors.textSecondary,
              textSize: 12,
            ),
            const SizedBox(height: 2),
            AppText(
              text: schedule,
              color: AppColors.black,
              textSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}

class _BookingRoute extends StatelessWidget {
  const _BookingRoute({
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.upcoming,
  });

  final String pickupAddress;
  final String dropoffAddress;
  final bool upcoming;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          start: upcoming ? 8 : 11,
          top: upcoming ? 12 : 12,
          bottom: upcoming ? 15 : 20,
          child: const SizedBox(
            width: 2,
            child: CustomPaint(painter: _RouteDashesPainter()),
          ),
        ),
        Column(
          children: [
            _LocationRow(
              pickup: true,
              address: pickupAddress,
              upcoming: upcoming,
            ),
            SizedBox(height:15),
            _LocationRow(
              pickup: false,
              address: dropoffAddress,
              upcoming: upcoming,
            ),
          ],
        ),
      ],
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({
    required this.pickup,
    required this.address,
    required this.upcoming,
  });

  final bool pickup;
  final String address;
  final bool upcoming;

  @override
  Widget build(BuildContext context) {
    final markerColor = pickup ? AppColors.primary : AppColors.express;
    final markerSize = upcoming ? 18.0 : 26.0;
    return SizedBox(
      height: upcoming ? 38 : 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: markerSize,
            height: markerSize,
            decoration: BoxDecoration(
              color: upcoming
                  ? AppColors.white
                  : (pickup
                        ? AppColors.pickupMarkerBackground
                        : AppColors.dropoffMarkerBackground),
              shape: BoxShape.circle,
              border: upcoming
                  ? Border.all(color: markerColor, width: 1.5)
                  : null,
            ),
            child: upcoming
                ? Icon(
                    pickup ? Icons.circle_outlined : Icons.location_on_outlined,
                    color: markerColor,
                    size: 12,
                  )
                : pickup
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
          SizedBox(width: upcoming ? 8 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: pickup ? AppStrings.pickup : AppStrings.dropoff,
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
                  maxLines: 1,
                ),
              ],
            ),
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
