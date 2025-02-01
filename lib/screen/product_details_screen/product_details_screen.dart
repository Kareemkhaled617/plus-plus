import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/product_details_screen/widgets/product_counter_section.dart';
import 'package:plus/screen/product_details_screen/widgets/product_description_and_brand_section.dart';
import 'package:plus/screen/product_details_screen/widgets/product_details_header.dart';
import 'package:plus/screen/product_details_screen/widgets/product_images_section.dart';
import 'package:plus/screen/product_details_screen/widgets/product_price_section.dart';
import 'package:plus/screen/product_details_screen/widgets/product_types_section.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';
import 'package:plus/utils/app_keys.dart';
import 'package:plus/utils/size_config.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ProductDetailsHeader(),
            ProductImagesSection(),
            SizedBox(
              height: 16,
            ),
            Divider(
              color: Colors.grey.shade300.withOpacity(.5),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              AppKeys.whatDoYouNeed.tr,
              style: AppFonts.heading2.copyWith(fontSize: getResponsiveFontSize(15)),
            ),
            ProductTypesSection(),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ProductCounterSection(),
            ),
            SizedBox(
              height: 8,
            ),
            ProductPriceSection(),
            SizedBox(
              height: 20,
            ),
            ProductDescriptionAndBrandSection(),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: () {},
                label: Icon(
                  Icons.shopping_cart_outlined,
                  size: 26,
                  color: AppColors.white,
                ),
                icon: Text(
                  AppKeys.addToCart.tr,
                  style: AppFonts.bodyText.copyWith(
                      color: AppColors.white,
                      fontSize: getResponsiveFontSize(16),
                      fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
