import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/size_config.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../domain/entities/category_entity.dart';
import '../../modules/sub_category/sub_category_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';
import 'cached_image.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoryGrid({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child:
          // Wrap(
          //
          //   children: [
          //     ...List.generate(categories.length, (index) {
          //       final category = categories[index];
          //       return InkWell(
          //         onTap: () {
          //           Get.toNamed(
          //             AppRoutes.subCategories,
          //             arguments: {
          //               'title': category.name,
          //               'id': category.id,
          //               // 'catList' :category.
          //             },
          //           );
          //         },
          //         child: Container(
          //           width: getProportionateScreenWidth(80),
          //           margin: EdgeInsets.symmetric(horizontal: 10),
          //           child: Column(
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                   color: AppColors.categoryBackground,
          //                   borderRadius: BorderRadius.circular(20),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 18.0, vertical: 14),
          //                   child: CachedImage(
          //                     imageUrl: category.imageUrl,
          //                     fit: BoxFit.contain,
          //                     height: getProportionateScreenHeight(50),
          //                     // Optional if you want rounded corners
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(height: 8),
          //               Text(
          //                 category.name,
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //                 style: AppFonts.bodyText.copyWith(
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w500,
          //                   color: AppColors.primary,
          //                 ),
          //                 textAlign: TextAlign.center,
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     }),
          //   ],
          // )

          GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1.7,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              Get.toNamed(
                AppRoutes.subCategories,
                arguments: {
                  'title': category.name,
                  'id': category.id,
                  // 'catList' :category.
                },
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
                    child: CachedImage(
                      imageUrl: category.imageUrl,
                      fit: BoxFit.fill,
                      height: 60,
                      // Optional if you want rounded corners
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.bodyText.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
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
