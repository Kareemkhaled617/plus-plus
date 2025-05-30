import 'package:get/get.dart';
import 'package:plus/app/modules/change_phone_number/change_phone_number.dart';
import 'package:plus/app/modules/favourite_screen/binding/favourite_binding.dart';
import 'package:plus/app/modules/login_screen/binding/auth_binding.dart';

import '../binding/app_binding.dart';
import '../binding/product_binding.dart';
import '../binding/sup_category_binding.dart';
import '../modules/access_location/access_location_screen.dart';
import '../modules/account_screen/account_screen.dart';
import '../modules/account_screen/binding/account_binding.dart';
import '../modules/address_directory/address_directory.dart';
import '../modules/address_directory/binding/address_binding.dart';
import '../modules/all_prescription/all_prescription_screen.dart';
import '../modules/all_prescription/bindind/prescription_binding.dart';
import '../modules/brands_screen/binding/brand_binding.dart';
import '../modules/brands_screen/brands_screen.dart';
import '../modules/cart/binding/cart_binding.dart';
import '../modules/cart/cart_screen.dart';
import '../modules/change_phone_number/binding/change_phone_binding.dart';
import '../modules/check_out_screen/binding/order_request_binding.dart';
import '../modules/check_out_screen/check_out_screen.dart';
import '../modules/favourite_screen/favourite_screen.dart';
import '../modules/home_screen/home_screen.dart';
import '../modules/landing_screen/landing_screen.dart';
import '../modules/login_screen/login_screen.dart';
import '../modules/notification_screen/binding/notification_binding.dart';
import '../modules/notification_screen/notifications_screen.dart';
import '../modules/offers_screen/widget/widget/all_discount_product.dart';
import '../modules/order_details_screen/bindings/order_details_binding.dart';
import '../modules/order_details_screen/order_details_screen.dart';
import '../modules/order_history_screen/binding/order_binding.dart';
import '../modules/order_history_screen/order_history_screen.dart';
import '../modules/otp_screen/binding/otp_binding.dart';
import '../modules/otp_screen/otp_screen.dart';
import '../modules/prescription_completed/prescription_completed_screen.dart';
import '../modules/prescription_screen/binding/prescription_binding.dart';
import '../modules/prescription_screen/prescription_screen.dart';
import '../modules/privacy_policy/binding/privacy_policy_binding.dart';
import '../modules/product_details_screen/binding/product_binding.dart';
import '../modules/product_details_screen/binding/product_point_binding.dart';
import '../modules/product_details_screen/product_details_screen.dart';
import '../modules/products_screen/binding/all_product_binding.dart';
import '../modules/products_screen/products_screen.dart';
import '../modules/rewards_screen/points_screen.dart';
import '../modules/splash_screen/splash_screen.dart';
import '../modules/sub_category/sub_category_screen.dart';
import '../modules/video_player_screen/spalsh_image.dart';
import '../modules/video_player_screen/video_player_screen.dart';
import '../modules/view_offers_screen/pinding/product_offer_binding.dart';
import '../modules/view_offers_screen/view_offers_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.fullScreenImageScreen,
      page: () => FullScreenImageScreen(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.landingScreen,
      page: () => LandingScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.videoPlayer,
      page: () => const VideoSplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      bindings: [AuthBinding(), PrivacyPolicyBinding()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      // binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.viewOffers,
      page: () => ViewOffersScreen(),
      binding: ProductOffersBinding(),
    ),
    GetPage(
      name: AppRoutes.favouriteScreen,
      page: () => FavouriteScreen(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: AppRoutes.rewards,
      page: () => RewardsScreen(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.brandsScreen,
      page: () => BrandsScreen(),
      binding: BrandBinding(),
    ),
    GetPage(
      name: AppRoutes.subCategories,
      page: () => SubCategoryScreen(),
      bindings: [ProductBinding(), SupCategoryBinding()],
    ),
    GetPage(
      name: AppRoutes.productsScreen,
      page: () => ProductsScreen(
        gradientColors: Get.arguments?['gradientColors'] ?? [],
        title: Get.arguments?['title'] ?? '',
      ),
      binding: AllProductBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartScreen(),
      // binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => ProductDetailsScreen(),
      bindings: [ProductDetailsBinding(), ProductPointBinding()],
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => OTPVerificationScreen(),
      bindings: [OTPBinding(), AuthBinding(), CartBinding(), FavoriteBinding()],
    ),
    GetPage(
        name: AppRoutes.prescription,
        page: () => PrescriptionScreen(),
        binding: PrescriptionBinding()),
    GetPage(
      name: AppRoutes.allPrescription,
      page: () => AllPrescriptionScreen(),
      binding: GetPrescriptionBinding(),
    ),
    GetPage(
      name: AppRoutes.orderHistory,
      page: () => OrderHistoryScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: AppRoutes.accountScreen,
      page: () => AccountScreen(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: AppRoutes.addressDirectory,
      page: () => AddressDirectory(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: AppRoutes.prescriptionCompletedScreen,
      page: () => PrescriptionCompletedScreen(),
    ),
    GetPage(
      name: AppRoutes.accessLocationScreen,
      page: () => AccessLocationScreen(),
    ),
    GetPage(
        name: AppRoutes.orderDetailsScreen,
        page: () => OrderDetailsScreen(),
        binding: OrderDetailsBinding()),
    GetPage(
        name: AppRoutes.checkOutScreen,
        page: () => CheckOutScreen(),
        binding: CheckoutBinding()),
    GetPage(
        name: AppRoutes.changePhoneScreen,
        page: () => ChangePhoneScreen(),
        binding: ChangePhoneBinding()),
    GetPage(
      name: AppRoutes.allDiscountProductsScreen,
      page: () => AllDiscountProductsScreen(),
    ),
  ];
}
