import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/routes/app_routes.dart';
import '../../../data/models/booking_model.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/booking_card.dart';
import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppHeader(
          title: AppStrings.bookings,
          centerTitle: true,
          showBackButton: false,
          height: 56,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
          child: Container(
            height: 38,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(
              () => Row(
                children: [
                  _tab(AppStrings.ongoing, 0),
                  _tab(AppStrings.upcoming, 1),
                  _tab(AppStrings.completed, 2),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () {
              final _ = controller.selectedTab.value;
              return controller.isLoading.value
                  ? const _BookingsShimmer()
                  : _buildBody();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    final bookings = controller.bookingsForSelectedTab();
    if (bookings.isEmpty) {
      return _EmptyBookings(tab: _emptyStateLabel());
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(9, 8, 9, 22),
      itemCount: bookings.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => _bookingCard(bookings[index]),
    );
  }

  Widget _tab(String text, int index) {
    final selected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.setTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: AppText(
            text: text,
            color: selected ? AppColors.white : AppColors.black,
            textSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _bookingCard(BookingModel booking) {
    final type = _cardTypeForTab();
    final dateText = _dateLabel(booking.pickupDate);
    final timeText = _formatTime(booking.pickupTime);
    return BookingCard(
      type: type,
      orderNumber: booking.orderNumber?.isNotEmpty == true
          ? booking.orderNumber!
          : '#${booking.id ?? ''}',
      pickupAddress: booking.pickupAddress ?? '',
      dropoffAddress: booking.dropoffAddress ?? '',
      time: _scheduleText(dateText, timeText),
      schedule: _scheduleText(dateText, timeText),
      status: _statusLabel(booking),
      statusColor: _statusColor(booking),
      actionText: AppStrings.track,
      onAction: () => _openTracking(booking.id),
      onTap: () => _openBookingDetails(booking.id),
      onCancel: () => _openBookingDetails(booking.id),
    );
  }

  BookingCardType _cardTypeForTab() {
    switch (controller.selectedTab.value) {
      case 1:
        return BookingCardType.upcoming;
      case 2:
        return BookingCardType.completed;
      default:
        return BookingCardType.ongoing;
    }
  }

  String _statusLabel(BookingModel booking) {
    switch (booking.status) {
      case BookingStatus.delivered:
        return AppStrings.delivered;
      case BookingStatus.orderPickedUp:
        return AppStrings.orderPickedUp;
      case BookingStatus.driverOnTheWay:
        return AppStrings.driverOnWay;
      case BookingStatus.accepted:
        return 'Accepted';
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.unknown:
        return '';
    }
  }

  Color _statusColor(BookingModel booking) {
    switch (booking.status) {
      case BookingStatus.delivered:
        return AppColors.deliveredStatus;
      case BookingStatus.orderPickedUp:
        return AppColors.bookingStatusOrange;
      case BookingStatus.driverOnTheWay:
        return AppColors.bookingStatusGrey;
      case BookingStatus.accepted:
        return AppColors.bookingStatusGrey;
      case BookingStatus.pending:
        return AppColors.bookingStatusGrey;
      case BookingStatus.cancelled:
        return AppColors.bookingStatusGrey;
      case BookingStatus.unknown:
        return AppColors.bookingStatusGrey;
    }
  }

  String _scheduleText(String dateText, String timeText) {
    if (dateText.isEmpty) return timeText;
    if (timeText.isEmpty) return dateText;
    return '$dateText • $timeText';
  }

  String _emptyStateLabel() {
    switch (controller.selectedTab.value) {
      case 1:
        return 'No upcoming request found';
      case 2:
        return 'No completed request found';
      default:
        return 'No ongoing request found';
    }
  }

  String _dateLabel(DateTime? date) {
    if (date == null) return '';
    final today = DateUtils.dateOnly(DateTime.now());
    final target = DateUtils.dateOnly(date);
    if (target == today) return 'Today';
    if (target == today.add(const Duration(days: 1))) return 'Tomorrow';
    return DateFormat('dd MMM yyyy').format(date);
  }

  String _formatTime(String? value) {
    if (value == null || value.isEmpty) return '';
    final parsed = DateFormat('HH:mm:ss').parse(value);
    return DateFormat('hh:mm a').format(parsed);
  }

  static void _openBookingDetails(String? id) {
    Get.toNamed<void>(
      AppRoutes.bookingDetails,
      arguments: {'requestId': id},
    );
  }

  static void _openTracking(String? id) {
    Get.toNamed<void>(AppRoutes.trackDelivery);
  }
}

class _EmptyBookings extends StatelessWidget {
  const _EmptyBookings({required this.tab});

  final String tab;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText(
        text: tab,
        color: AppColors.black,
        textSize: 16,
        fontWeight: FontWeight.w700,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _BookingsShimmer extends StatelessWidget {
  const _BookingsShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(9, 8, 9, 22),
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => Container(
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
            _ShimmerLine(widthFactor: 0.42),
            SizedBox(height: 14),
            _ShimmerLine(widthFactor: 1),
            SizedBox(height: 10),
            _ShimmerLine(widthFactor: 0.75),
            SizedBox(height: 10),
            Divider(height: 1),
            SizedBox(height: 12),
            _ShimmerLine(widthFactor: 0.42),
          ],
        ),
      ),
    );
  }
}

class _ShimmerLine extends StatelessWidget {
  const _ShimmerLine({required this.widthFactor});

  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * widthFactor,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.border.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }
}
