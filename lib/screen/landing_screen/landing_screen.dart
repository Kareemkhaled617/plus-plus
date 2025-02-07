import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';
import 'package:plus/screen/cart/cart_screen.dart';
import 'package:plus/screen/home_screen/home_screen.dart';
import 'package:plus/screen/profile_screen/profile_screen.dart';
import 'package:plus/screen/search_screen/search_screen.dart';
import 'package:plus/utils/app_keys.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int selectedIndex = 0;
  final screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    Center(child: Text("Profile Screen")),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          selectedIndex = value;
          setState(() {});

        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnselectedHome,
              height: 30,
            ),
            activeIcon: Image.asset(
              Assets.iconsSelectedHome,
              height: 30,
            ),
            label: AppKeys.home.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnSelectedSearch,
              height: 27,
            ),
            activeIcon: Image.asset(
              Assets.iconsSelectedSearch,
              height: 30,
            ),
            label: AppKeys.search.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnselectedCart,
              height: 30,
            ),
            activeIcon: Image.asset(
              Assets.iconsSelectedCart,
              height: 30,
            ),
            label: AppKeys.cart.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnselectedOffers,
              height: 30,
            ),
            activeIcon: Image.asset(
              Assets.iconsSelectedOffers,
              height: 30,
            ),
            label: AppKeys.offers.tr,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              Assets.iconsUnselectedProfile,
              height: 30,
            ),
            activeIcon: Image.asset(
              Assets.iconsSelectedProfile,
              height: 30,
            ),
            label: AppKeys.profile.tr,
          ),
        ],
      ),
    );
  }
}
