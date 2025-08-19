import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (context, index) => shimmerProductCard(),
      ),
    );
  }

  Widget shimmerProductCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 6),
          // Price
          Container(height: 12, width: 60, color: Colors.white),
          const SizedBox(height: 4),
          // Title
          Container(height: 10, width: double.infinity, color: Colors.white),
          const SizedBox(height: 4),
          Container(height: 10, width: 80, color: Colors.white),
        ],
      ),
    );
  }
}
