import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/routes/app_routes.dart';
import '../../../data/models/home_model.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_image_view.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/booking_card.dart';
import '../controllers/dashboard_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.hasCreatedRequest,
    required this.onViewAll,
  });

  final bool hasCreatedRequest;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return Column(
      children: [
        const _HomeHeader(),
        Expanded(
          child: Obx(
            () => controller.isHomeLoading.value
                ? const _HomeShimmer()
                : controller.hasHomeItems
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _DeliveredSummary(
                              totalDelivered:
                                  controller.homeData.value?.totalDelivered ??
                                  0,
                            ),
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
                                  onTap: onViewAll,
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
                            ..._buildBookingCards(
                              controller.homeData.value?.todayBookings ??
                                  const [],
                            ),
                          ],
                        ),
                      )
                    : const _EmptyHome(),
          ),
        ),
      ],
    );
  }

  static void _openTracking() {
    Get.toNamed<void>(AppRoutes.trackDelivery);
  }

  static void _openBookingDetails() {
    Get.toNamed<void>(AppRoutes.bookingDetails);
  }

  static List<Widget> _buildBookingCards(List<HomeBooking> bookings) {
    return bookings
        .map(
          (booking) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookingCard(
              type: BookingCardType.ongoing,
              orderNumber: booking.orderNumber == null
                  ? ''
                  : '#${booking.orderNumber}',
              status: _statusLabel(booking.status),
              statusColor: _statusColor(booking.status),
              pickupAddress: booking.pickupLocation ?? '',
              dropoffAddress: booking.dropoffLocation ?? '',
              time: _bookingTime(booking),
              onAction: _openTracking,
              onTap: _openBookingDetails,
            ),
          ),
        )
        .toList();
  }

  static String _bookingTime(HomeBooking booking) {
    final dateLabel = _bookingDateLabel(booking.scheduledDate);
    final timeLabel = _bookingTime12Hour(booking.scheduledTimeFrom);
    if (dateLabel.isEmpty) return timeLabel;
    if (timeLabel.isEmpty) return dateLabel;
    return '$dateLabel • $timeLabel';
  }

  static String _bookingDateLabel(String? rawDate) {
    final parsed = _parseDate(rawDate);
    if (parsed == null) return rawDate ?? '';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selected = DateTime(parsed.year, parsed.month, parsed.day);
    if (selected == today) return 'Today';
    if (selected == today.add(const Duration(days: 1))) return 'Tomorrow';
    return DateFormat('dd MMM yyyy').format(parsed);
  }

  static String _bookingTime12Hour(String? rawTime) {
    final parsed = _parseTime(rawTime);
    if (parsed == null) return rawTime ?? '';
    final time = TimeOfDay(hour: parsed.hour, minute: parsed.minute);
    return DateFormat(
      'hh:mm a',
    ).format(DateTime(2000, 1, 1, time.hour, time.minute));
  }

  static DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  static DateTime? _parseTime(String? value) {
    if (value == null || value.isEmpty) return null;
    final parts = value.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return DateTime(2000, 1, 1, hour, minute);
  }

  static String _statusLabel(int? status) {
    return switch (status) {
      0 => AppStrings.orderPickedUp,
      1 => AppStrings.driverOnWay,
      2 => AppStrings.delivered,
      3 => 'cancelled',
      _ => AppStrings.orderPickedUp,
    };
  }

  static Color _statusColor(int? status) {
    return switch (status) {
      0 => AppColors.bookingStatusOrange,
      1 => AppColors.bookingStatusGrey,
      2 => AppColors.success,
      3 => AppColors.error,
      _ => AppColors.bookingStatusGrey,
    };
  }
}

class _EmptyHome extends StatelessWidget {
  const _EmptyHome();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.homeDummy,
              width: 95,
              height: 69,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 14),
            const AppText(
              text: AppStrings.noDeliveryRequests,
              color: AppColors.black,
              textSize: 16,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const AppText(
              text: AppStrings.noDeliveryRequestsDescription,
              color: AppColors.textSecondary,
              textSize: 12,
              lineHeight: 1.45,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: AppStrings.createRequest,
              onTap: () => Get.toNamed<void>(AppRoutes.createRequest),
              height: 56,
              borderRadius: 14,
              showShadow: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeShimmer extends StatefulWidget {
  const _HomeShimmer();

  @override
  State<_HomeShimmer> createState() => _HomeShimmerState();
}

class _HomeShimmerState extends State<_HomeShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ShimmerCard(height: 92),
              const SizedBox(height: 14),
              const _ShimmerLine(widthFactor: 0.45),
              const SizedBox(height: 12),
              const _ShimmerBookingCard(),
              const SizedBox(height: 12),
              const _ShimmerBookingCard(),
              const SizedBox(height: 12),
              const _ShimmerBookingCard(),
            ],
          ),
        );
      },
    );
  }
}

class _ShimmerBookingCard extends StatelessWidget {
  const _ShimmerBookingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _ShimmerLine(widthFactor: 0.38),
          SizedBox(height: 14),
          _ShimmerLine(widthFactor: 1),
          SizedBox(height: 10),
          _ShimmerLine(widthFactor: 0.72),
          SizedBox(height: 10),
          Divider(height: 1),
          SizedBox(height: 12),
          _ShimmerLine(widthFactor: 0.42),
        ],
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ShimmerLine(widthFactor: 0.38, height: 14),
            _ShimmerBox(width: 60, height: 60),
          ],
        ),
      ),
    );
  }
}

class _ShimmerLine extends StatelessWidget {
  const _ShimmerLine({
    required this.widthFactor,
    this.height = 12,
  });

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth * widthFactor
            : 120.0;
        return Align(
          alignment: Alignment.centerLeft,
          child: _ShimmerBox(width: effectiveWidth, height: height),
        );
      },
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({this.width, required this.height});

  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final actualWidth = width ?? constraints.maxWidth;
        return _ShimmerGradientBox(width: actualWidth, height: height);
      },
    );
  }
}

class _ShimmerGradientBox extends StatefulWidget {
  const _ShimmerGradientBox({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<_ShimmerGradientBox> createState() => _ShimmerGradientBoxState();
}

class _ShimmerGradientBoxState extends State<_ShimmerGradientBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment(-1.0 + (_controller.value * 2), 0),
              end: Alignment(1.0 + (_controller.value * 2), 0),
              colors: const [
                Color(0xFFF1EEF8),
                Color(0xFFE4DBF2),
                Color(0xFFF1EEF8),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return Obx(
      () => Container(
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
            AppImageView(
              imageUrl: controller.profileImageUrl,
              width: 32,
              height: 32,
              isCircle: true,
              placeholderPadding: const EdgeInsets.all(7),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: controller.user.value?.fullName.isNotEmpty == true
                        ? controller.user.value!.fullName
                        : AppStrings.homeGreeting,
                    color: AppColors.black,
                    textSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 2),
                  const AppText(
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
      ),
    );
  }
}

class _DeliveredSummary extends StatelessWidget {
  const _DeliveredSummary({required this.totalDelivered});

  final int totalDelivered;

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
          Column(
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
                text: totalDelivered.toString(),
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
