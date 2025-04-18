import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../generated/assets.dart';
import '../../core/storage/secure_storage_helper.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthToken();
  }

  /// **Check if user is authenticated**
  Future<void> _checkAuthToken() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate loading
    String? token = await SecureStorageHelper().getData("auth_token");

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.landingScreen); // Go to home if token exists
    } else {
      Get.offAllNamed(AppRoutes.login); // Otherwise, go to login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TweenAnimationBuilder(
          duration: const Duration(seconds: 3),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          builder: (context, double value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: value,
                child: child,
              ),
            );
          },
          child: Image.asset(Assets.imagesLogo),
        ),
      ),
    );
  }
}
