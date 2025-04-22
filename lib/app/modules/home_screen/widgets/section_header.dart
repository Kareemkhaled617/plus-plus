import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/size_config.dart';
import '../../account_screen/controller/account_controller.dart';
import '../../address_directory/controllor/address_controller.dart';
import '../../notification_screen/notifications_screen.dart';
import '../../rewards_screen/points_screen.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    this.isProfileSection = false,
  });

  final bool isProfileSection;

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.find<AccountController>();
    final addressController = Get.find<AddressController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text('${AppKeys.welcome.tr}  ! ',
                  style: AppFonts.heading1.copyWith(
                      color:
                          isProfileSection ? AppColors.black : AppColors.white,
                      fontSize: 21)),
              Spacer(),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.rewards);
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
                      FutureBuilder(
                          future: controller.fetchPoints(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(controller.points.value.toString(),
                                  style: AppFonts.bodyText.copyWith(
                                    color: AppColors.black,
                                  ));
                            } else {
                              return Container();
                            }
                          })
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.notification);
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
              Obx(() {
                if (addressController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (addressController.address.value != null) {
                  final address = addressController.address.value!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width - 80,
                        child: Text(
                          address.address.address,
                          maxLines: 3,
                          style: AppFonts.bodyText.copyWith(
                              color: isProfileSection
                                  ? AppColors.black
                                  : AppColors.white,
                              fontSize: isProfileSection ? 12 : 14,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      if (!isProfileSection)
                        address.availableForDelivery
                            ? Container()
                            : Text(
                                AppKeys.weDontHaveDeliveryHere.tr,
                                style: AppFonts.bodyText.copyWith(
                                  color: AppColors.yellowAccent,
                                  fontSize: 16,
                                ),
                              ),
                    ],
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.accessLocationScreen,
                          arguments: {'edit': false});
                    },
                    child: Center(
                        child: Text('No address available'.tr,
                            style: AppFonts.bodyText
                                .copyWith(color: Colors.white))),
                  );
                }
              }),
            ],
          ),
        ],
      ),
    );
  }
}
