import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_scontroller.dart';
import '../../../core/theme/app_colors.dart';



class CircularImageSlider extends StatelessWidget {
  final List<String> imageUrls;

  CircularImageSlider({super.key, required this.imageUrls});

  final HomeController _sliderController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 260.0,
          padding: EdgeInsets.symmetric(vertical: 20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: PageView.builder(
            onPageChanged: (index) => _sliderController.updateIndex(index),
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Image.asset(
                imageUrls[index],
                fit: BoxFit.fill,
                width: 150,
                height: 150,
              );
            },
          ),
        ),
        SizedBox(height: 16.0),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageUrls.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
                  width: _sliderController.currentIndex.value == index
                      ? 8.0
                      : 8.0,
                  decoration: BoxDecoration(
                    color: _sliderController.currentIndex.value == index
                        ? AppColors.primary
                        : AppColors.grey,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
