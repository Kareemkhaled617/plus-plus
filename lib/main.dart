import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/splash_screen/splash_screen.dart';
import 'package:plus/utils/size_config.dart';

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
      home: const SplashScreen(),
    );
  }
}
