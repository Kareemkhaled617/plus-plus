import 'package:plus/app/modules/account_screen/account_screen.dart';
import 'package:plus/app/modules/address_directory/address_directory.dart';
import 'package:plus/app/modules/all_prescription/all_prescription_screen.dart';
import 'package:plus/app/modules/brands_screen/brands_screen.dart';
import 'package:plus/app/modules/login_screen/login_screen.dart';
import 'package:plus/app/modules/notification_screen/notifications_screen.dart';
import 'package:plus/app/modules/otp_screen/otp_screen.dart';
import 'package:plus/app/modules/products_screen/products_screen.dart';
import 'package:plus/app/modules/rewards_screen/points_screen.dart';
import 'package:plus/app/modules/sub_category/sub_category_screen.dart';
import '../modules/cart/cart_screen.dart';
import '../modules/order_history_screen/order_history_screen.dart';
import '../modules/prescription_screen/prescription_screen.dart';
import '../modules/product_details_screen/product_details_screen.dart';
import '../modules/splash_screen/splash_screen.dart';
import '../modules/view_offers_screen/view_offers_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String resetPassword = '/reset_password';
  static const String successRegister = '/successRegister';
  static const String viewOffers = '/ViewOffers';
  static const String rewards = '/Rewards';
  static const String notification = '/Notification';
  static const String productsScreen = '/products-screen';
  static const String subCategories = '/categories';
  static const String brandsScreen = '/brands-screen';
  static const String cart = '/cart';
  static const String productDetails = '/productDetails';
  static const String checkout = '/checkout';
  static const String otp = '/otp';
  static const String prescription = '/prescription';
  static const String allPrescription = '/all-prescription';
  static const String orderHistory = '/orderHistory';
  static const String accountScreen = '/account-screen';
  static const String addressDirectory = '/address-directory';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fadeRoute(SplashScreen(), settings);

      case login:
        return _fadeRoute(LoginScreen(), settings);

      case viewOffers:
        return _fadeRoute(ViewOffersScreen(), settings);

      case rewards:
        return _fadeRoute(RewardsScreen(), settings);

      case notification:
        return _fadeRoute(NotificationScreen(), settings);

      case brandsScreen:
        return _fadeRoute(BrandsScreen(), settings);

      case subCategories:
        final title = settings.arguments as String;
        return _fadeRoute(SubCategoryScreen(title: title), settings);
      case productsScreen:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final gradientColors = args['gradientColors'] as List<Color>? ?? [];
        final title = args['title'] as String? ?? '';
        return _fadeRoute(
          ProductsScreen(gradientColors: gradientColors, title: title),
          settings,
        );

      case cart:
        return _fadeRoute(CartScreen(), settings);

      case productDetails:
        return _fadeRoute(ProductDetailsScreen(), settings);

      case otp:
        return _fadeRoute(OTPVerificationScreen(), settings);

      case prescription:
        return _fadeRoute(PrescriptionScreen(), settings);

      case allPrescription:
        return _fadeRoute(AllPrescriptionScreen(), settings);

      case orderHistory:
        return _fadeRoute(OrderHistoryScreen(), settings);

      case accountScreen:
        return _fadeRoute(AccountScreen(), settings);

      case addressDirectory:
        return _fadeRoute(AddressDirectory(), settings);

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Route<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('Page not found!')),
      ),
    );
  }
}
