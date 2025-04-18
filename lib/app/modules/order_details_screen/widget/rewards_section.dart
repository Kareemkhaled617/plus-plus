import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../routes/app_routes.dart';

class RewardsSection extends StatelessWidget {
  const RewardsSection({super.key, required this.orderEntity});

  final OrderEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return orderEntity.userPointsEarned == 0
        ? Container()
        : Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.babyBlue.withOpacity(.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppKeys.youEarned.tr} ${orderEntity.userPointsEarned} ${AppKeys.points.tr}!",
                        style: AppFonts.heading2.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        AppKeys.redeem.tr,
                        style: AppFonts.bodyText.copyWith(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.rewards);
                        },
                        child: Text(
                          AppKeys.viewMyRewards.tr,
                          style: AppFonts.headline1
                              .copyWith(color: AppColors.primary, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Image.asset(Assets.imagesEarnedPoint)),
              ],
            ),
          );
  }
}
