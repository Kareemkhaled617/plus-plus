import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/theme/app_colors.dart';
import 'app/core/utils/size_config.dart';
import 'app/modules/splash_screen/splash_screen.dart';
import 'app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plus Plus',
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: AppColors.primary,
        unselectedWidgetColor: AppColors.greyWithShade,
      ),
      home: const SplashScreen(),
    );
  }
}
