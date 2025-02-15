import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';


class ProductImagesSection extends StatefulWidget {
  const ProductImagesSection({super.key});

  @override
  State<ProductImagesSection> createState() => _ProductImagesSectionState();
}

class _ProductImagesSectionState extends State<ProductImagesSection> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;
  final List<String> imageUrls = [
    Assets.tempCream,
    Assets.tempCream,
    Assets.tempCream,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imageUrls[index],
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(Assets.iconsShare, width: 35),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imageUrls.length,
                    (index) => GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedIndex == index
                                  ? AppColors.blue
                                  : AppColors.greyWithShade.withOpacity(0),
                              width: selectedIndex == index ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            imageUrls[index],
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(width: 16),
        
        // Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageUrls.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                width: selectedIndex == index ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  color: selectedIndex == index
                      ? AppColors.primary
                      : AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
