import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../home_screen/controller/banner_controller.dart';
import '../../home_screen/controller/category_controller.dart';
import '../../home_screen/controller/section_controller.dart';


class LandingController extends GetxController {
  /// current bottom tab index
  final RxInt currentIndex = 0.obs;

  /// other controllers used for refresh
  late final BannerController bannerController;
  late final CategoryController categoryController;
  late final SectionController sectionController;

  @override
  void onInit() {
    super.onInit();
    // Ensure dependencies exist (already bound in their modules)
    bannerController = Get.find<BannerController>();
    categoryController = Get.find<CategoryController>();
    sectionController = Get.find<SectionController>();

    // Status bar style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  /// Set the selected tab index
  void setIndex(int index) {
    currentIndex.value = index;

    // Auto refresh when switching to home
    if (index == 0) {
      refreshHomeContent();
    }
  }

  /// Pull-to-refresh or tab-to-refresh on Home
  Future<void> refreshHomeContent() async {
    await Future.wait<void>([
      bannerController.fetchBanners(),
      categoryController.fetchCategories(),
      sectionController.fetchSections(),
    ]);
  }

  /// Handle Android back: if not on home, go to home instead of popping
  Future<bool> onWillPop() async {
    if (currentIndex.value != 0) {
      setIndex(0);
      return false; // consume back
    }
    return true; // allow system to pop/exit
  }
}
