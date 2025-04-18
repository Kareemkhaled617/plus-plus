import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cached_image.dart';
import '../controller/product_controller.dart';

class ProductImagesSection extends StatefulWidget {
  const ProductImagesSection({super.key, required this.controller});

  final ProductDetailsController controller;

  @override
  State<ProductImagesSection> createState() => _ProductImagesSectionState();
}

class _ProductImagesSectionState extends State<ProductImagesSection> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

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
                  itemCount: widget.controller.product.value!.bodyImages.length,
                  itemBuilder: (context, index) {
                    return CachedImage(
                      imageUrl:
                          widget.controller.product.value!.bodyImages[index],
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
                    widget.controller.product.value!.bodyImages.length,
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
                          child: CachedImage(
                            height: 50,
                            width: 50,
                            imageUrl: widget
                                .controller.product.value!.bodyImages[index],
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
            widget.controller.product.value!.bodyImages.length,
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
