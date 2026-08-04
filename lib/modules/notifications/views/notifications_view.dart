import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../generated/asset_paths.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  static const _notifications = [
    _NotificationData(
      icon: Assets.completedIcon,
      title: AppStrings.deliveryUpdate,
      description: AppStrings.deliveryUpdateDescription,
      time: AppStrings.twoMinutesAgo,
      iconBackground: AppColors.softPrimary,
      iconColor: AppColors.primary,
    ),
    _NotificationData(
      icon: Assets.bookingIcon,
      title: AppStrings.newOrderAlert,
      description: AppStrings.newOrderDescription,
      time: AppStrings.oneHourAgo,
      iconBackground: Color(0xFFD9FBE7),
      iconColor: AppColors.positive,
    ),
    _NotificationData(
      icon: Assets.settingsIcon,
      title: AppStrings.systemUpdate,
      description: AppStrings.systemUpdateDescription,
      time: AppStrings.threeHoursAgo,
    ),
    _NotificationData(
      icon: Assets.mapIcon,
      title: AppStrings.routeOptimized,
      description: AppStrings.routeOptimizedDescription,
      time: AppStrings.yesterday,
    ),
    _NotificationData(
      icon: Assets.moneyIcon,
      title: AppStrings.paymentReceived,
      description: AppStrings.paymentReceivedDescription,
      time: AppStrings.twoDaysAgo,
      iconBackground: Color(0xFFD9FBE7),
      iconColor: AppColors.positive,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: AppStrings.notifications,
              titleColor: AppColors.primary,
              backIconColor: AppColors.primary,
              height: 64,
              centerTitle: true,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  18,
                  AppSpacing.screenHorizontal,
                  20,
                ),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: AppStrings.notifications,
                              color: AppColors.primary,
                              textSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                            SizedBox(height: 3),
                            AppText(
                              text: AppStrings.notificationsDescription,
                              color: AppColors.blackNewColor,
                              textSize: 13,
                              fontWeight: FontWeight.w500,
                              lineHeight: 1.35,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.markAllAsRead,
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: AppText(
                            text: AppStrings.markAllAsRead,
                            color: AppColors.primary,
                            textSize: 13,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            lineHeight: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ...List.generate(
                    _notifications.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        bottom: index == _notifications.length - 1 ? 0 : 9,
                      ),
                      child: Obx(
                        () => _NotificationCard(
                          data: _notifications[index],
                          isRead: controller.isRead(index),
                          onTap: () => controller.markAsRead(index),
                        ),
                      ),
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

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.data,
    required this.isRead,
    required this.onTap,
  });

  final _NotificationData data;
  final bool isRead;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 3,
                decoration: BoxDecoration(
                  color: isRead ? AppColors.transparent : AppColors.primary,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: data.iconBackground,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: SvgPicture.asset(
                          data.icon,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            data.iconColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: data.title,
                              color: AppColors.textPrimary,
                              textSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            AppText(
                              text: data.description,
                              color: AppColors.textSecondary,
                              textSize: 12,
                              lineHeight: 1.35,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(
                            text: data.time,
                            color: AppColors.textSecondary,
                            textSize: 11,
                          ),
                          if (!isRead) ...[
                            const SizedBox(height: 7),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: SizedBox(width: 7, height: 7),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationData {
  const _NotificationData({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    this.iconBackground = AppColors.fragileColor,
    this.iconColor = AppColors.orLoginWith,
  });

  final String icon;
  final String title;
  final String description;
  final String time;
  final Color iconBackground;
  final Color iconColor;
}
