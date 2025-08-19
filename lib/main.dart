import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/core/service/localization_service.dart';
import 'app/core/service/notification_services.dart';
import 'app/core/storage/secure_storage_helper.dart';
import 'app/core/theme/app_colors.dart';
import 'app/core/utils/size_config.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primary,
    statusBarIconBrightness: Brightness.light,
  ));
  await NotificationService().initNotification();
  String? savedLang = await SecureStorageHelper().getData("language");

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(
  //       initialLocale: savedLang != null
  //           ? Locale(savedLang)
  //           : LocalizationService.defaultLocale,
  //     ), // Wrap your app
  //   ),
  // );
  runApp(MyApp(
    initialLocale: savedLang != null
        ? Locale(savedLang)
        : LocalizationService.defaultLocale,
  ));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'El Lewaa',
      initialRoute: AppRoutes.videoPlayer,
      getPages: AppPages.pages,
      locale: initialLocale,
      // initialBinding: AppBinding(),
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        fontFamily:
            initialLocale.languageCode == 'en' ? 'Roboto' : 'NotoSansArabic',
        primaryColor: AppColors.primary,
        unselectedWidgetColor: AppColors.greyWithShade,
          snackBarTheme: SnackBarThemeData(
            backgroundColor: AppColors.primary,
            insetPadding: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
      // home: HomePageShimmer(),
    );
  }
}
