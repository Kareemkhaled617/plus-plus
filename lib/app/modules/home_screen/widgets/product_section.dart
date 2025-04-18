import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/core/utils/color_helper.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/product_item.dart';
import '../../../domain/entities/section_entity.dart';
import '../../product_details_screen/product_details_screen.dart';
import '../../products_screen/products_screen.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key, required this.section});

  final SectionEntity section;

  @override
  Widget build(BuildContext context) {
    return section.products.isNotEmpty
        ? Container(
            padding: EdgeInsets.all(14),
            margin: EdgeInsets.only(left: 8, top: 18, right: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Color(0xFFB0C5FF).withOpacity(.3),
                  // Color(0xFF4A00E0).withOpacity(.4),
                  HexColor(section.firstColor),
                  HexColor(section.secondColor),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      section.name,
                      style: AppFonts.heading2.copyWith(
                          color: HexColor(section.titleColor),
                          fontWeight: FontWeight.w700,
                          fontSize: getResponsiveFontSize(17)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.productsScreen,
                            arguments: {
                              "gradientColors": [
                                HexColor(section.firstColor),
                                HexColor(section.secondColor),
                              ],
                              "title": section.name,
                              "id": section.id,
                              'isSection': true
                            });
                      },
                      child: Text(
                        AppKeys.viewAll.tr,
                        style: AppFonts.heading2.copyWith(
                            color: HexColor(section.titleColor),
                            fontSize: getResponsiveFontSize(15),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        section.products.length,
                        (index) => ProductCard(
                          imageUrl: section.products[index].imageUrl,
                          title: section.products[index].name,
                          stockInfo:
                              "${section.products[index].stock} in stock",
                          price: "${section.products[index].price} L.E",
                          onFavorite: () {},
                          onAddToCart: () {},
                          id: section.products[index].id,
                          productEntity: section.products[index],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: 100,
            height: 200,
          );
  }
}
