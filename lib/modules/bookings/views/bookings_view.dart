import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/common/booking_card.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  int _selectedTab = 0;

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
            child: Row(
              children: [
                _tab(AppStrings.ongoing, 0),
                _tab(AppStrings.upcoming, 1),
                _tab(AppStrings.completed, 2),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(9, 8, 9, 22),
            children: _cardsForSelectedTab(),
          ),
        ),
      ],
    );
  }

  Widget _tab(String text, int index) {
    final selected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _selectedTab = index),
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

  List<Widget> _cardsForSelectedTab() {
    if (_selectedTab == 1) {
      return const [
        BookingCard(
          type: BookingCardType.upcoming,
          orderNumber: '#FND-1234',
          pickupAddress: AppStrings.mainDistributionCenter,
          dropoffAddress: AppStrings.urbanHeightsResidence,
          time: AppStrings.october26Schedule,
          schedule: AppStrings.october26Schedule,
          onAction: _openBookingDetails,
        ),
      ];
    }
    if (_selectedTab == 2) {
      return const [
        BookingCard(
          type: BookingCardType.completed,
          orderNumber: '#SWL-88294-TX',
          pickupAddress: AppStrings.evergreenTerrace,
          dropoffAddress: AppStrings.industrialWay,
          time: AppStrings.october12Date,
          status: AppStrings.delivered,
          statusColor: AppColors.deliveredStatus,
          onTap: _openCompletedBookingDetails,
        ),
      ];
    }
    return const [
      BookingCard(
        type: BookingCardType.ongoing,
        orderNumber: '#FND-8821',
        pickupAddress: AppStrings.centralLogisticsHub,
        dropoffAddress: AppStrings.bakerStreet,
        time: AppStrings.today1430,
        status: AppStrings.orderPickedUp,
        statusColor: AppColors.bookingStatusOrange,
        onAction: _openTracking,
      ),
      SizedBox(height: 10),
      BookingCard(
        type: BookingCardType.ongoing,
        orderNumber: '#FND-9042',
        pickupAddress: AppStrings.docklandsWarehouse,
        dropoffAddress: AppStrings.regentsPark,
        time: AppStrings.today1615,
        status: AppStrings.driverOnWay,
        statusColor: AppColors.bookingStatusGrey,
        onAction: _openTracking,
      ),
      SizedBox(height: 10),
      BookingCard(
        type: BookingCardType.ongoing,
        orderNumber: '#FND-7761',
        pickupAddress: AppStrings.urbanFreshGrocery,
        dropoffAddress: AppStrings.privateResidence,
        time: AppStrings.tomorrow0900,
        actionText: AppStrings.details,
        onAction: _openBookingDetails,
      ),
    ];
  }

  static void _openBookingDetails() {
    Get.toNamed<void>(AppRoutes.bookingDetails);
  }

  static void _openCompletedBookingDetails() {
    Get.toNamed<void>(
      AppRoutes.bookingDetails,
      arguments: const {'completed': true},
    );
  }

  static void _openTracking() {
    Get.toNamed<void>(AppRoutes.trackDelivery);
  }
}
