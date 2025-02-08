import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/home_screen/widgets/section_header.dart';
import 'package:plus/screen/profile_screen/widget/profile_all_properties.dart';
import 'package:plus/screen/profile_screen/widget/profile_total_activities_card.dart';
import 'package:plus/utils/app_keys.dart';
import '../../generated/assets.dart';
import '../../utils/app_fonts.dart';
import '../favourite_screen/favourite_screen.dart';
import '../order_history_screen/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              isProfileSection: true,
            ),
            SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ProfileTotalActivitiesCard(
                          title: AppKeys.favourite.tr,
                          image: Assets.imagesFavouriteCardBg,
                          onTap: () {
                            Get.to(
                              () => const FavouriteScreen(),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ProfileTotalActivitiesCard(
                          title: AppKeys.history.tr,
                          image: Assets.imagesHistoryCardBg,
                          onTap: () {
                            Get.to(OrderHistoryScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  ProfileAllProperties(),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      "You can follow us on :",
                      style: AppFonts.heading3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          Assets.iconsFacebook,
                          width: 40,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image.asset(
                          Assets.iconsInstagram,
                          width: 40,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
