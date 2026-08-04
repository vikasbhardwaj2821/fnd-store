import 'package:flutter/material.dart';

import '../../../generated/asset_paths.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/common/app_colors.dart';
import '../../../utils/common/app_header.dart';
import '../../../utils/common/app_text.dart';

class DriverReviewsView extends StatelessWidget {
  const DriverReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: AppStrings.driverReviews,
              centerTitle: true,
              height: 56,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 18),
                children: const [
                  _DriverSummary(),
                  SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: AppStrings.latestReviews,
                          color: AppColors.textSecondary,
                          textSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppText(
                        text: AppStrings.mostRecent,
                        color: AppColors.primary,
                        textSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  _ReviewCard(
                    initials: 'SW',
                    name: AppStrings.reviewerSarah,
                    time: AppStrings.twoDaysAgoReview,
                    review: AppStrings.reviewOne,
                    color: AppColors.callColor,
                  ),
                  SizedBox(height: 10),
                  _ReviewCard(
                    initials: 'MR',
                    name: AppStrings.reviewerMark,
                    time: AppStrings.oneWeekAgo,
                    review: AppStrings.reviewTwo,
                    color: AppColors.softPrimary,
                  ),
                  SizedBox(height: 10),
                  _ReviewCard(
                    initials: 'JL',
                    name: AppStrings.reviewerJames,
                    time: AppStrings.twoWeeksAgo,
                    review: AppStrings.reviewThree,
                    color: AppColors.deliveredStatus,
                  ),
                  SizedBox(height: 12),
                  _LoadMoreButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DriverSummary extends StatelessWidget {
  const _DriverSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(Assets.driverPhoto),
          ),
          SizedBox(height: 10),
          AppText(
            text: AppStrings.driverName,
            color: AppColors.black,
            textSize: 17,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: AppColors.express, size: 18),
              SizedBox(width: 4),
              AppText(
                text: '4.9',
                color: AppColors.black,
                textSize: 15,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(width: 4),
              AppText(text: '/5', color: AppColors.textSecondary, textSize: 11),
            ],
          ),
          SizedBox(height: 5),
          AppText(
            text: AppStrings.reviewsTotal,
            color: AppColors.textSecondary,
            textSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.initials,
    required this.name,
    required this.time,
    required this.review,
    required this.color,
  });
  final String initials;
  final String name;
  final String time;
  final String review;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: color,
                child: AppText(
                  text: initials,
                  color: AppColors.primary,
                  textSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppText(
                  text: name,
                  color: AppColors.black,
                  textSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppText(text: time, color: AppColors.textSecondary, textSize: 9),
            ],
          ),
          const SizedBox(height: 7),
          const Row(
            children: [
              Icon(Icons.star, color: AppColors.express, size: 12),
              Icon(Icons.star, color: AppColors.express, size: 12),
              Icon(Icons.star, color: AppColors.express, size: 12),
              Icon(Icons.star, color: AppColors.express, size: 12),
              Icon(Icons.star, color: AppColors.express, size: 12),
            ],
          ),
          const SizedBox(height: 7),
          AppText(
            text: review,
            color: AppColors.bodyText,
            textSize: 11,
            fontWeight: FontWeight.w500,
            lineHeight: 1.45,
          ),
        ],
      ),
    );
  }
}

class _LoadMoreButton extends StatelessWidget {
  const _LoadMoreButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: AppStrings.loadMoreReviews,
            color: AppColors.primary,
            textSize: 11,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(width: 5),
          Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 16),
        ],
      ),
    );
  }
}
