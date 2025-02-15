import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/brands_screen/brands_screen.dart';
import 'package:plus/screen/home_screen/widgets/best_seller.dart';
import 'package:plus/components/category_item.dart';
import 'package:plus/screen/home_screen/widgets/circular_image_slider.dart';
import 'package:plus/screen/home_screen/widgets/prescription.dart';
import 'package:plus/screen/home_screen/widgets/ready_for_winter.dart';
import 'package:plus/screen/home_screen/widgets/section_header.dart';
import 'package:plus/screen/home_screen/widgets/special_brands.dart';
import '../../components/disclaimer_box.dart';
import '../../generated/assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(46),
                        topRight: Radius.circular(46)),
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularImageSlider(
                        imageUrls: [
                          Assets.tempBanner,
                          Assets.tempBanner,
                          Assets.tempBanner,
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DisclaimerBox(
                        message:
                            'Products are displayed, sold and delivered on behalf of our pharmacy partner ',
                        highlightedText: 'El Lewaa Elteby',
                        onHighlightTap: () {},
                        message1:
                            ' pharmacy and under its full medical supervision.',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Categories'.tr,
                          textAlign: TextAlign.start,
                          style: AppFonts.heading1.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CategoryGrid(categories: [
                        {'title': 'Medicine', 'imageUrl': Assets.tempDsd},
                        {'title': 'Skin care', 'imageUrl': Assets.tempDsd},
                        {'title': 'Hair care', 'imageUrl': Assets.tempDsd},
                        {'title': 'Baby care', 'imageUrl': Assets.tempDsd},
                        {
                          'title': 'Animals Supplies',
                          'imageUrl': Assets.tempDsd
                        },
                        {'title': 'Daily care', 'imageUrl': Assets.tempDsd},
                        {
                          'title': 'Medicine Supplies',
                          'imageUrl': Assets.tempDsd
                        },
                        {'title': 'Make up', 'imageUrl': Assets.tempDsd},
                      ]),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Add your prescription here'.tr,
                          textAlign: TextAlign.start,
                          style: AppFonts.heading2.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Prescription(),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'PLUS PLUS Offers'.tr,
                          textAlign: TextAlign.start,
                          style: AppFonts.heading2.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      CircularImageSlider(
                        imageUrls: [
                          Assets.tempBanner,
                          Assets.tempBanner,
                          Assets.tempBanner,
                        ],
                      ),
                      SizedBox(height: 16),
                      BestSeller(),
                      SizedBox(height: 16),
                      ReadyForWinter(),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Special brands'.tr,
                              style: AppFonts.heading2,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(BrandsScreen());
                              },
                              child: Text(
                                'View all'.tr,
                                style: AppFonts.heading2.copyWith(
                                    color: AppColors.primary, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SpecialBrand(
                        categories: [
                          {'title': 'Medicine', 'imageUrl': Assets.tempImg},
                          {'title': 'Skin care', 'imageUrl': Assets.tempImg},
                          {'title': 'Hair care', 'imageUrl': Assets.tempImg},
                          {'title': 'Baby care', 'imageUrl': Assets.tempImg},
                          {
                            'title': 'Animals Supplies',
                            'imageUrl': Assets.tempImg
                          },
                          {'title': 'Daily care', 'imageUrl': Assets.tempImg},
                          {
                            'title': 'Medicine Supplies',
                            'imageUrl': Assets.tempImg
                          },
                          {'title': 'Make up', 'imageUrl': Assets.tempImg},
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.white,
          onPressed: () {},
          label: Row(
            children: [
              Text(
                'Contact us',
                style: AppFonts.bodyText
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              Image(
                image: AssetImage(Assets.iconsWhatsapp),
                width: 50,
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
