import 'package:flutter/material.dart';

import '../../../core/utils/shimmer.dart';
import '../../../core/utils/size_config.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        padding: EdgeInsets.symmetric(horizontal: 18),
        separatorBuilder: (_, __) => SizedBox(
          width: getProportionateScreenWidth(30),
        ),
        itemBuilder: (_, __) => Column(
          children: [
            shimmerCircle(size: 70),
            const SizedBox(height: 6),
            shimmerBox(height: 10, width: 50),
            const SizedBox(height: 16),
            shimmerCircle(size: 70),
            const SizedBox(height: 6),
            shimmerBox(height: 10, width: 50),
          ],
        ),
      ),
    );
  }
}
