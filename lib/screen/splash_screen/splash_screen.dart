import 'package:flutter/material.dart';
import 'package:plus/screen/home_screen/home_screen.dart';
import 'package:plus/screen/home_screen/widgets/prescription.dart';
import 'package:plus/screen/prescription_completed/prescription_completed_screen.dart';
import 'package:plus/screen/prescription_screen/prescription_screen.dart';
import 'package:plus/screen/search_screen/search_screen.dart';
import 'package:plus/utils/common_widgets.dart';
import '../../generated/assets.dart';
import '../brands_screen/brands_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TweenAnimationBuilder(
          duration: Duration(seconds: 3),
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
          child: Image.asset(
            Assets.imagesLogo,
          ),
          onEnd: () {
            CommonWidgets.navigateWithFade(BrandsScreen());
          },
        ),
      ),
    );
  }
}
