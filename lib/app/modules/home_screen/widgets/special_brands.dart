import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/size_config.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/utils/color_helper.dart';
import '../../../core/widgets/cached_image.dart';
import '../../../domain/entities/section_entity.dart';
import '../../../routes/app_routes.dart';
import '../../products_screen/products_screen.dart';

class SpecialBrand extends StatelessWidget {
  final SectionEntity section;

  const SpecialBrand({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return section.brands.isNotEmpty
        ? SizedBox(
            height: getProportionateScreenHeight(220),
            // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        section.name,
                        style: AppFonts.heading2.copyWith(
                            color: HexColor(section.titleColor),
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.brandsScreen,
                              arguments: {'id': section.id.toString()});
                        },
                        child: Text(
                          AppKeys.viewAll.tr,
                          style: AppFonts.heading2.copyWith(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: getProportionateScreenWidth(50),
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: section.brands.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.productsScreen,
                              arguments: {
                                "gradientColors": [Colors.white, Colors.white],
                                "title": section.brands[index].name,
                                "id": section.brands[index].id,
                                'isSection': false,
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedImage(
                              // height: 100,
                              fit: BoxFit.contain,
                              imageUrl: section.brands[index].imageUrl,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 10),
          );
  }
}
