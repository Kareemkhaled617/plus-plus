import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:plus/generated/assets.dart';

import '../../binding/app_binding.dart';
import '../../core/utils/app_keys.dart';
import '../cart/cart_screen.dart';
import '../home_screen/controller/banner_controller.dart';
import '../home_screen/controller/category_controller.dart';
import '../home_screen/controller/section_controller.dart';
import '../home_screen/home_screen.dart';
import '../offers_screen/offers_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../search_screen/search_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selectedIndex = 0;

  final BannerController bannerController = Get.find<BannerController>();
  final CategoryController categoryController = Get.find<CategoryController>();
  final SectionController sectionController = Get.find<SectionController>();

  final screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    OffersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedIndex == 0
          ? RefreshIndicator(
              onRefresh: () async {
                await _refreshHomeContent();
              },
              child: screens[selectedIndex],
            )
          : screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;

            // Optional: Auto-refresh when navigating to Home tab
            if (selectedIndex == 0) {
              _refreshHomeContent();
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnselectedHome,
              height: 24,
            ),
            activeIcon: Column(
              children: [
                Image.asset(
                  Assets.iconsUnselectedHome,
                  height: 24,
                  color: AppColors.primary,
                ),
                SizedBox(height: 2),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                )
              ],
            ),
            label: AppKeys.home.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnSelectedSearch,
              height: 24,
            ),
            activeIcon: Column(
              children: [
                Image.asset(
                  Assets.iconsUnSelectedSearch,
                  height: 24,
                  color: AppColors.primary,
                ),
                SizedBox(height: 2),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                )
              ],
            ),
            label: AppKeys.search.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnselectedCart,
              height: 24,
            ),
            activeIcon: Column(
              children: [
                Image.asset(
                  Assets.iconsSelectedCart,
                  height: 24,
                  color: AppColors.primary,
                ),
                SizedBox(height: 2),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                )
              ],
            ),
            label: AppKeys.cart.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnselectedOffers,
              height: 30,
              fit: BoxFit.contain,
            ),
            activeIcon: Column(
              children: [
                Image.asset(
                  Assets.iconsSelectedOffers,
                  height: 24,
                  color: AppColors.primary,
                ),
                SizedBox(height: 2),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                )
              ],
            ),
            label: AppKeys.offers.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnselectedProfile,
              height: 24,
              fit: BoxFit.contain,
            ),
            activeIcon: Column(
              children: [
                Image.asset(
                  Assets.iconsSelectedProfile,
                  height: 24,
                  fit: BoxFit.contain,
                  color: AppColors.primary,
                ),
                SizedBox(height: 2),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                )
              ],
            ),
            label: AppKeys.profile.tr,
          ),
        ],
      ),
    );
  }

  Future<void> _refreshHomeContent() async {
    print('Refreshing home content...');
    await Future.wait<void>([
      bannerController.fetchBanners(),
      categoryController.fetchCategories(),
      sectionController.fetchSections(),
    ]);
  }
}
