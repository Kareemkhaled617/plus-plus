import 'package:flutter/material.dart';

import '../theme/app_colors.dart';


class OffersPercentWidget extends StatelessWidget {
  const OffersPercentWidget({super.key, this.percent = "-10"});
  final String percent;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Icon(
          Icons.bookmark,
          color: AppColors.red,
          size: 40,
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Text(
           percent ,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
