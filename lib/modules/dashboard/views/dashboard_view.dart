import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_text.dart';
import '../controllers/dashboard_controller.dart';
import 'bookings_view.dart';
import 'home_view.dart';
import 'profile_view.dart';
import 'settings_view.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: ColoredBox(
        color: AppColors.pageBackground,
        child: SafeArea(
          bottom: false,
          child: Obx(
            () => IndexedStack(
              index: controller.currentIndex.value == 2
                  ? 0
                  : controller.currentIndex.value,
              children: [
                HomeView(onViewAll: () => controller.changeTab(1)),
                const BookingsView(),
                const SizedBox.shrink(),
                const ProfileView(),
                const SettingsView(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => DashboardNavigation(
          selectedIndex: controller.currentIndex.value,
          onSelected: controller.changeTab,
          onCreate: () => Get.toNamed<void>(AppRoutes.createRequest),
        ),
      ),
    );
  }
}

class DashboardNavigation extends StatelessWidget {
  const DashboardNavigation({
    super.key,
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
              textSize: selected ?12:11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
