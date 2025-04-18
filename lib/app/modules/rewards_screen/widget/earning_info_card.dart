import 'package:flutter/material.dart';
import 'package:plus/app/domain/entities/point_entity.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class EarningInfoCard extends StatelessWidget {
  const EarningInfoCard({super.key, required this.point});

  final PointEntity point;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyWithShade.withOpacity(.1))),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  point.date,
                  style: AppFonts.bodyText.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  point.positive ? "Earn" : "Payment ${point.orderNumber}",
                  style: AppFonts.bodyText.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  point.orderNumber,
                  style: TextStyle(
                      color: AppColors.grey.withOpacity(.8),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(Assets.iconsCoin, width: 16, height: 16),
                    SizedBox(width: 4),
                    Text(
                      point.positive ? "+12" : "-50",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            point.positive ? AppColors.primary : AppColors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
