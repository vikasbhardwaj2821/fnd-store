import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_button.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';

class TrackDeliveryView extends StatefulWidget {
  const TrackDeliveryView({super.key});

  @override
  State<TrackDeliveryView> createState() => _TrackDeliveryViewState();
}

class _TrackDeliveryViewState extends State<TrackDeliveryView> {
  Timer? _deliveryTimer;
  bool _isDelivered = false;

  @override
  void initState() {
    super.initState();
    _deliveryTimer = Timer(const Duration(seconds: 12), () {
      if (mounted) setState(() => _isDelivered = true);
    });
  }

  @override
  void dispose() {
    _deliveryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDelivered) return const _DeliveredView();
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: AppStrings.trackDelivery,
              centerTitle: true,
              height: 56,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  _TrackingMap(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 14, 14, 18),
                    child: Column(
                      children: [
                        _CurrentStatusCard(),
                        SizedBox(height: 12),
                        _ArrivalCard(),
                        SizedBox(height: 12),
                        _DriverCard(),
                        SizedBox(height: 16),
                        _OrderFooter(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveredView extends StatelessWidget {
  const _DeliveredView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: AppStrings.trackDelivery,
              centerTitle: true,
              height: 56,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
                children: [
                  Center(
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: const BoxDecoration(
                        color: AppColors.softSuccess,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: AppColors.positive,
                        size: 43,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const AppText(
                    text: AppStrings.orderDeliveredSuccessfully,
                    color: AppColors.black,
                    textSize: 22,
                    fontWeight: FontWeight.w800,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const AppText(
                    text: AppStrings.packageDeliveredSafely,
                    color: AppColors.textSecondary,
                    textSize: 13,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const _DeliverySummaryCard(),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 145,
                      child: GoogleMap(
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(25.1950, 55.2880),
                          zoom: 16,
                        ),
                        mapType: MapType.satellite,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                        compassEnabled: false,
                        myLocationButtonEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        markers: {
                          const Marker(
                            markerId: MarkerId('delivered'),
                            position: LatLng(25.1950, 55.2880),
                          ),
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  AppButton(
                    text: AppStrings.backToHome,
                    onTap: () => Get.offAllNamed<void>(AppRoutes.dashboard),
                    height: 48,
                    borderRadius: 8,
                    textSize: 14,
                    showShadow: true,
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () => Get.toNamed<void>(AppRoutes.rateDelivery),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_border,
                          color: AppColors.primary,
                          size: 17,
                        ),
                        SizedBox(width: 6),
                        AppText(
                          text: AppStrings.rateDelivery,
                          color: AppColors.primary,
                          textSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliverySummaryCard extends StatelessWidget {
  const _DeliverySummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _DeliveryInfo(
                  label: AppStrings.timeOfDelivery,
                  value: AppStrings.deliveredTime,
                ),
              ),
              Expanded(
                child: _DeliveryInfo(
                  label: AppStrings.orderId,
                  value: '#FND-8821',
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          _DeliveryInfo(
            label: AppStrings.deliveryLocation,
            value: AppStrings.deliveredLocation,
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }
}

class _DeliveryInfo extends StatelessWidget {
  const _DeliveryInfo({required this.label, required this.value, this.icon});
  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          color: AppColors.textSecondary,
          textSize: 11,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.primary, size: 16),
              const SizedBox(width: 5),
            ],
            Expanded(
              child: AppText(
                text: value,
                color: AppColors.black,
                textSize: 13,
                fontWeight: FontWeight.w700,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TrackingMap extends StatelessWidget {
  const _TrackingMap();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 255,
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(25.2073, 55.2719),
              zoom: 13.6,
            ),
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            myLocationButtonEnabled: false,
            scrollGesturesEnabled: false,
            zoomGesturesEnabled: false,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: false,
            markers: {
              Marker(
                markerId: MarkerId('driver'),
                position: LatLng(25.2157, 55.2624),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet,
                ),
              ),
              Marker(
                markerId: MarkerId('pickup'),
                position: LatLng(25.2035, 55.2740),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueViolet,
                ),
              ),
              Marker(
                markerId: MarkerId('store'),
                position: LatLng(25.1950, 55.2880),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange,
                ),
              ),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId('delivery_route'),
                color: AppColors.primary,
                width: 5,
                points: [
                  LatLng(25.2157, 55.2624),
                  LatLng(25.2078, 55.2668),
                  LatLng(25.2104, 55.2772),
                  LatLng(25.1950, 55.2880),
                ],
              ),
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          color: AppColors.white,
          child: const Row(
            children: [
              Expanded(child: _Caption(AppStrings.pickupShort)),
              Expanded(child: _Caption(AppStrings.customerShort)),
              Expanded(child: _Caption(AppStrings.driverShort)),
            ],
          ),
        ),
      ],
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => AppText(
    text: text,
    color: AppColors.textSecondary,
    textSize: 8,
    fontWeight: FontWeight.w500,
    maxLines: 2,
  );
}

class _CurrentStatusCard extends StatelessWidget {
  const _CurrentStatusCard();
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(18),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: AppStrings.currentStatus,
          color: AppColors.white70,
          textSize: 11,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 5),
        AppText(
          text: AppStrings.headingToPickup,
          color: AppColors.white,
          textSize: 21,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(radius: 4, backgroundColor: AppColors.online),
            SizedBox(width: 7),
            AppText(
              text: AppStrings.driverOnTheWay,
              color: AppColors.white,
              textSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    ),
  );
}

class _ArrivalCard extends StatelessWidget {
  const _ArrivalCard();
  @override
  Widget build(BuildContext context) => _Card(
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppStrings.estimatedArrival,
                color: AppColors.textSecondary,
                textSize: 11,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 5),
              AppText(
                text: AppStrings.fiveMinutesAway,
                color: AppColors.primary,
                textSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.access_time,
            color: AppColors.white,
            size: 25,
          ),
        ),
      ],
    ),
  );
}

class _DriverCard extends StatelessWidget {
  const _DriverCard();
  @override
  Widget build(BuildContext context) => _Card(
    child: Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(Assets.driverPhoto),
            ),
            const SizedBox(width: 11),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: AppStrings.trackedDriverName,
                    color: AppColors.black,
                    textSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  AppText(
                    text: AppStrings.trackedDriverStats,
                    color: AppColors.textSecondary,
                    textSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Container(
              width: 42,
              height: 42,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: AppColors.softPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                Assets.callIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 24, color: AppColors.fieldBorder),
        const Row(
          children: [
            Icon(
              Icons.delivery_dining,
              size: 17,
              color: AppColors.textSecondary,
            ),
            SizedBox(width: 7),
            Expanded(
              child: AppText(
                text: AppStrings.trackedVehicle,
                color: AppColors.textSecondary,
                textSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _OrderFooter extends StatelessWidget {
  const _OrderFooter();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: AppStrings.orderId,
              color: AppColors.textSecondary,
              textSize: 10,
              fontWeight: FontWeight.w500,
            ),
            AppText(
              text: '#FND-8821',
              color: AppColors.primary,
              textSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
      GestureDetector(
        onTap: () => Get.toNamed<void>(
          AppRoutes.bookingDetails,
          arguments: const {'fromTrackDelivery': true},
        ),
        child: const Row(
          children: [
            AppText(
              text: AppStrings.viewOrderDetails,
              color: AppColors.primary,
              textSize: 12,
              fontWeight: FontWeight.w600,
            ),
            Icon(Icons.chevron_right, color: AppColors.primary, size: 18),
          ],
        ),
      ),
    ],
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: AppColors.fieldBorder),
    ),
    child: child,
  );
}
