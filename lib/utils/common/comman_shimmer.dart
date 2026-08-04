import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmerLoader extends StatelessWidget {
  final int itemCount;
  final double avatarHeight;
  final double avatarWidth;
  final double borderRadius;

  const CommonShimmerLoader({
    super.key,
    this.itemCount = 6,
    this.avatarHeight = 40,
    this.avatarWidth = 40,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (_, _) => Shimmer.fromColors(
        baseColor: const Color(0xFFE0E0E0),
        highlightColor: const Color(0xFFF5F5F5),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            children: [
              Container(
                height: avatarHeight,
                width: avatarWidth,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 12, width: 120, color: Colors.grey),
                    const SizedBox(height: 8),
                    Container(height: 10, width: 80, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
