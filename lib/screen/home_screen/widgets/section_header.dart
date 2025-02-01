import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/utils/size_config.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../notification_screen/notifications_screen.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
  });

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
                  style: AppFonts.heading1
                      .copyWith(color: AppColors.white, fontSize: 24)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
                    Text('1.972 ', style: AppFonts.bodyText),
                  ],
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
                  color: AppColors.white,
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
              Icon(Icons.location_on_outlined, color: AppColors.white),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Cairo- Elgash street",
                      style: AppFonts.bodyText
                          .copyWith(color: AppColors.white, fontSize: 20,fontWeight: FontWeight.w800)),
                  Text("We don’t deliver here !",
                      style: AppFonts.bodyText.copyWith(
                          color: AppColors.yellowAccent, fontSize: 18)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
