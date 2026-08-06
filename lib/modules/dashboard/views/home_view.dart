import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/booking_card.dart';

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
    return Column(
      children: [
        const _HomeHeader(),
        Expanded(
          child: hasCreatedRequest
              ? SingleChildScrollView(
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
                      const BookingCard(
                        type: BookingCardType.ongoing,
                        orderNumber: '#FND-8821',
                        status: AppStrings.orderPickedUp,
                        statusColor: AppColors.bookingStatusOrange,
                        pickupAddress: AppStrings.downtownHub,
                        dropoffAddress: AppStrings.westsideTerminal,
                        time: AppStrings.today1430,
                        onAction: _openTracking,
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
                        onAction: _openTracking,
                      ),
                    ],
                  ),
                )
              : const _EmptyHome(),
        ),
      ],
    );
  }

  static void _openTracking() {
    Get.toNamed<void>(AppRoutes.trackDelivery);
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
