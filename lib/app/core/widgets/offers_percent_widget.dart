import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class OffersPercentWidget extends StatelessWidget {
  const OffersPercentWidget({super.key, this.percent = "-10"});

  final String percent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.bookmark,
          color: AppColors.red,
          size: 44,
        ),
        Text(
          percent,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
