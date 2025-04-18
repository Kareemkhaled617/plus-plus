import 'package:flutter/material.dart';

import '../../../core/utils/shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
