import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> handleBannerTap({
  required String urlType,
  required String url,
  String? bannerUrlType,
}) async {
  if (urlType == 'outside_app') {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error'.tr, 'Cannot open the link.');
    }
  } else {
    if (bannerUrlType == 'products') {
      Get.toNamed(AppRoutes.productDetails, arguments: {
        'productId': int.parse(url),
      });
    } else if (bannerUrlType == 'categories') {
      Get.toNamed(
        AppRoutes.subCategories,
        arguments: {
          'title': 'categories',
          'id': int.parse(url),
          // 'catList' :category.
        },
      );
    } else if (bannerUrlType == 'brands') {
      Get.toNamed(AppRoutes.productsScreen, arguments: {
        "gradientColors": [
          Colors.white,
          Colors.white,
        ],
        "title": 'brand',
        "id":  int.parse(url),
        'isSection': false,
      });
    } else {
      Get.snackbar('Navigation', 'No valid destination specified.');
    }
  }
}
