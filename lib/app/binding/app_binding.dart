import 'package:get/get.dart';
import 'package:plus/app/binding/section_binding.dart';
import '../core/storage/secure_storage_helper.dart';
import '../modules/account_screen/binding/account_binding.dart';
import '../modules/account_screen/binding/business_settings_binding.dart';
import '../modules/address_directory/binding/address_binding.dart';
import '../modules/cart/binding/cart_binding.dart';
import '../modules/cart/binding/related_product_binding.dart';
import '../modules/cart/controller/cart_controller.dart';
import '../modules/favourite_screen/binding/favourite_binding.dart';
import '../modules/home_screen/arrival_timer/presentation/binding/binding.dart';
import '../modules/home_screen/bindiing/banner_binding.dart';
import '../modules/landing_screen/landing_binding.dart';
import '../modules/notification_screen/binding/notification_binding.dart';
import '../modules/offers_screen/binding/discount_binding.dart';
import '../modules/offers_screen/binding/offer_binding.dart';
import '../modules/privacy_policy/binding/privacy_policy_binding.dart';
import '../modules/product_details_screen/binding/product_point_binding.dart';
import '../modules/profile_screen/bindind/language_binding.dart';
import '../modules/search_screen/binding/recent_search_binding.dart';
import '../modules/search_screen/binding/search_binding.dart';
import 'category_binding.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    print('AppBinding dependencies');

    LandingBinding().dependencies();
    Get.lazyPut<SecureStorageHelper>(() => SecureStorageHelper());
    CategoryBinding().dependencies();
    NotificationBinding().dependencies();
    FavoriteBinding().dependencies();
    ProductPointBinding().dependencies();
    OfferBinding().dependencies();
    DiscountBinding().dependencies();
    SectionBinding().dependencies();
    RecentSearchBinding().dependencies();
    AccountBinding().dependencies();
    BusinessSettingsBinding().dependencies();
    RelatedProductBinding ().dependencies();
    BannerBinding ().dependencies();
    EstimationTimeBinding ().dependencies();
    SearchBinding().dependencies();
    FavoriteBinding().dependencies();
    LanguageBinding().dependencies();
    PrivacyPolicyBinding().dependencies();
    CartBinding().dependencies();
    AddressBinding().dependencies();


  }
}
