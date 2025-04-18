import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/cached_image.dart';

import '../../../core/utils/shimmer.dart';
import '../../../core/utils/url_helper.dart';
import '../../../domain/entities/banner_entity.dart';
import '../controller/banner_controller.dart';
import '../controller/home_scontroller.dart';
import '../../../core/theme/app_colors.dart';

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
                    height: 150.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      _sliderController.updateIndex(index);
                    },
                  ),
                  items: bannerController.banners
                      .where((banner) => banner.position == "in_top")
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
  CircularImageSlider1({super.key});

  final HomeController _sliderController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    BannerController bannerController = Get.find<BannerController>();

    return Obx(() {
      return bannerController.isLoading.value
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: shimmerBox(height: 150, width: Get.width),
            )
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      _sliderController.updateIndex1(index);
                    },
                  ),
                  items: bannerController.banners
                      .where((banner) => banner.position == "in_middle")
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
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        bannerController.banners
                            .where((banner) => banner.position == "in_middle")
                            .toList()
                            .length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: _sliderController.currentIndex1.value == index
                              ? 16.0
                              : 8.0,
                          decoration: BoxDecoration(
                            color:
                                _sliderController.currentIndex1.value == index
                                    ? AppColors.primary
                                    : AppColors.grey,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    )),
              ],
            );
    });
  }
}
