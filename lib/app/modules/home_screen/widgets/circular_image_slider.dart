import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/banner_shimmer.dart';
import 'package:plus/app/core/widgets/cached_image.dart';
import 'package:plus/app/domain/entities/banner_entity.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/utils/shimmer.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/url_helper.dart';
import '../controller/banner_controller.dart';
import '../controller/home_scontroller.dart';

class CircularImageSlider extends StatelessWidget {
  CircularImageSlider({super.key});

  final HomeController _sliderController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    BannerController bannerController = Get.find<BannerController>();
    // List<BannerEntity> topBanners = bannerController.banners
    //     .where((banner) => banner.position == "in_top")
    //     .toList();
    return Obx(() {
      return bannerController.isLoading.value
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: shimmerBox(height: 150, width: Get.width),
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 160.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      _sliderController.updateIndex(index);
                    },
                  ),
                  items: bannerController.banners
                      .where((banner) => (banner.position == "intro" &&
                          banner.actionType == "external"))
                      .toList()
                      .map((banner) {
                    return InkWell(
                      onTap: () async {
                        await handleBannerTap(
                            urlType: banner.urlType,
                            url: banner.url.toString(),
                            bannerUrlType: banner.bannerUrlType);
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedImage(
                            imageUrl: banner.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    bannerController.banners
                        .where((banner) => banner.position == "in_top")
                        .toList()
                        .length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: _sliderController.currentIndex.value == index
                          ? 16.0
                          : 8.0,
                      decoration: BoxDecoration(
                        color: _sliderController.currentIndex.value == index
                            ? AppColors.primary
                            : AppColors.grey,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                )
              ],
            );
    });
  }
}

class CircularImageSlider1 extends StatelessWidget {
  CircularImageSlider1({super.key, required this.banners});

  final List<BannerEntity> banners;
  final HomeController _sliderController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 16),
        //   child: Text(
        //     AppKeys.pOffers.tr,
        //     textAlign: TextAlign.start,
        //     style: AppFonts.heading1.copyWith(
        //         fontSize: getResponsiveFontSize(17),
        //         fontWeight: FontWeight.w700),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        CarouselSlider(
          options: CarouselOptions(
            height: 170.0,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              _sliderController.updateIndex1(index);
            },
          ),
          items: banners.toList().map((banner) {
            return InkWell(
              onTap: () async {
                await handleBannerTap(
                    urlType: banner.urlType,
                    url: banner.url.toString(),
                    bannerUrlType: banner.bannerUrlType);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedImage(
                    imageUrl: 'https://plusp.msarweb.net/storage/${banner.image}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.toList().length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
                  width: _sliderController.currentIndex1.value == index
                      ? 16.0
                      : 8.0,
                  decoration: BoxDecoration(
                    color: _sliderController.currentIndex1.value == index
                        ? AppColors.primary
                        : AppColors.grey,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
