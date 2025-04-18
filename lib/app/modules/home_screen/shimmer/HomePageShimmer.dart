import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  Widget shimmerBox(
      {double height = 20,
      double width = double.infinity,
      BorderRadius? radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget shimmerCircle({double size = 60}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerBox(height: 20, width: 200), // Welcome message
          const SizedBox(height: 10),
          shimmerBox(height: 15, width: 150), // Address
          const SizedBox(height: 20),

          // Offer Banner Slider
          shimmerBox(height: 150, radius: BorderRadius.circular(12)),
          const SizedBox(height: 16),

          // Pharmacy info
          shimmerBox(height: 60, radius: BorderRadius.circular(12)),
          const SizedBox(height: 16),

          // Categories
          SizedBox(
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, __) => Column(
                children: [
                  shimmerCircle(),
                  const SizedBox(height: 6),
                  shimmerBox(height: 10, width: 50),
                  const SizedBox(height: 16),
                  shimmerCircle(),
                  const SizedBox(height: 6),
                  shimmerBox(height: 10, width: 50),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Prescription upload banner
          shimmerBox(height: 80, radius: BorderRadius.circular(12)),
          const SizedBox(height: 24),

          // Offer Slider
          shimmerBox(height: 120, radius: BorderRadius.circular(12)),
          const SizedBox(height: 24),

          // Best Seller Title
          shimmerBox(height: 20, width: 150),
          const SizedBox(height: 12),

          // Product Cards (Best Seller)
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, __) => shimmerBox(
                  height: 180, width: 140, radius: BorderRadius.circular(12)),
            ),
          ),

          const SizedBox(height: 24),

          // Ready For Winter Title
          shimmerBox(height: 20, width: 180),
          const SizedBox(height: 12),

          // Product Cards (Winter)
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, __) => shimmerBox(
                  height: 180, width: 140, radius: BorderRadius.circular(12)),
            ),
          ),

          const SizedBox(height: 24),

          // Special Brands Title
          shimmerBox(height: 20, width: 140),
          const SizedBox(height: 16),

          // Brand icons
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              6,
              (index) => shimmerBox(
                  height: 60, width: 100, radius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
