import 'package:get/get.dart';
import 'package:plus/app/modules/login_screen/login_screen.dart';

import '../modules/splash_screen/splash_screen.dart';
import '../modules/view_offers_screen/view_offers_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String resetPassword = '/reset_password';
  static const String successRegister = '/successRegister';
  static const String viewOffersScreen = '/ViewOffersScreen';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: viewOffersScreen, page: () => ViewOffersScreen()),
  ];
}
