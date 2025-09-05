import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_keys.dart';
import '../cart/cart_screen.dart';
import '../cart/controller/cart_controller.dart';
import '../home_screen/home_screen.dart';
import '../offers_screen/offers_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../search_screen/search_screen.dart';
import 'controller/landing_controller.dart';


class LandingScreen extends GetView<LandingController> {
  const LandingScreen({super.key});

  List<Widget> get _screens => const [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    OffersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Obx(() {
        final idx = controller.currentIndex.value;

        return Scaffold(
          body: IndexedStack(
            index: idx,
            children: [
              // Keep Home wrapped with RefreshIndicator only
              RefreshIndicator(
                onRefresh: controller.refreshHomeContent,
                child: _screens[0],
              ),
              _screens[1],
              _screens[2],
              _screens[3],
              _screens[4],
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: AppColors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: idx,
            onTap: controller.setIndex,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(Assets.iconsUnselectedHome, height: 24),
                activeIcon: _ActiveIcon(Assets.iconsUnselectedHome),
                label: AppKeys.home.tr,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(Assets.iconsUnselectedSearch, height: 24),
                activeIcon: _ActiveIcon(Assets.iconsUnselectedSearch),
                label: AppKeys.search.tr,
              ),
              BottomNavigationBarItem(
                icon: Obx(() {
                  final cartCount = cartController.itemCounts.length;
                  return _CartIcon(
                    asset: Assets.iconsUnselectedCart,
                    count: cartCount,
                  );
                }),
                activeIcon: Column(
                  children: [
                    Obx(() {
                      final cartCount = cartController.itemCounts.length;
                      return _CartIcon(
                        asset: Assets.iconsSelectedCart,
                        count: cartCount,
                        tintPrimary: true,
                      );
                    }),
                    const SizedBox(height: 2),
                    _Dot(),
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
                activeIcon: _ActiveIcon(Assets.iconsSelectedOffers),
                label: AppKeys.offers.tr,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.iconsUnselectedProfile,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                activeIcon: _ActiveIcon(
                  Assets.iconsSelectedProfile,
                  fit: BoxFit.contain,
                ),
                label: AppKeys.profile.tr,
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// Small helper for active icon with primary tint and a dot under it
class _ActiveIcon extends StatelessWidget {
  const _ActiveIcon(this.asset, {this.fit});
  final String asset;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(asset, height: 24, color: AppColors.primary, fit: fit),
        const SizedBox(height: 2),
        _Dot(),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration:
      const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
    );
  }
}

class _CartIcon extends StatelessWidget {
  const _CartIcon({
    required this.asset,
    required this.count,
    this.tintPrimary = false,
  });

  final String asset;
  final int count;
  final bool tintPrimary;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          asset,
          height: 24,
          color: tintPrimary ? AppColors.primary : null,
        ),
        if (count > 0)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Center(
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
