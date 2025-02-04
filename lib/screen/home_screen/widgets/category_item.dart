import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';
import 'package:plus/utils/common_widgets.dart';

import '../../sub_category/sub_category_screen.dart';

class CategoryGrid extends StatelessWidget {
  final List<Map<String, String>> categories;

  const CategoryGrid({
    required this.categories,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1.66,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              Get.to(
                () => SubCategoryScreen(
                  title: category['title']!,
                ),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500),
              );
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.categoryBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child:
                        Image.asset(category['imageUrl']!, fit: BoxFit.contain),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  category['title']!,
                  style: AppFonts.bodyText.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
