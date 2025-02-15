import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/order_details_screen/widget/rewards_section.dart';
import 'package:plus/screen/rewards_screen/points_screen.dart';
import 'package:plus/utils/size_config.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../notification_screen/notifications_screen.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    this.isProfileSection = false,
  });

  final bool isProfileSection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text('Welcome sara ! ',
                  style: AppFonts.heading1.copyWith(
                      color:
                          isProfileSection ? AppColors.black : AppColors.white,
                      fontSize: 21)),
              Spacer(),
              InkWell(
                onTap: () {

                  Get.to(RewardsScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(Assets.iconsStar),
                        width: getProportionateScreenHeight(22),
                        height: getProportionateScreenHeight(22),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('1.972 ',
                          style: AppFonts.bodyText.copyWith(
                            color: AppColors.black,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  Get.to(NotificationScreen());
                },
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: isProfileSection ? AppColors.primary : AppColors.white,
                  size: 30,
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: isProfileSection ? AppColors.black : AppColors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Cairo- Elgash street",
                    style: AppFonts.bodyText.copyWith(
                        color: isProfileSection
                            ? AppColors.black
                            : AppColors.white,
                        fontSize: isProfileSection ? 12 : 18,
                        fontWeight: FontWeight.w800),
                  ),
                  if (!isProfileSection)
                    Text(
                      "We don’t deliver here !",
                      style: AppFonts.bodyText.copyWith(
                        color: AppColors.yellowAccent,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
