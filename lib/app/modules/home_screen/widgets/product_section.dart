import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/core/utils/color_helper.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/product_item.dart';
import '../../../domain/entities/section_entity.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key, required this.section});

  final SectionEntity section;

  @override
  Widget build(BuildContext context) {
    return section.products.isNotEmpty
        ? Container(
            padding: EdgeInsets.all(14),
            margin: EdgeInsets.only(left: 8, top: 18, right: 8),
            decoration: section.backgroundColor.isNotEmpty
                ? BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(section.backgroundColor),
                        fit: BoxFit.contain))
                : BoxDecoration(
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
                    Flexible(
                      child: Text(
                        section.name,
                        maxLines: 1,
                        style: AppFonts.heading2.copyWith(
                            color: HexColor(section.titleColor),
                            fontWeight: FontWeight.w700,
                            fontSize: getResponsiveFontSize(17)),
                      ),
                    ),
                    Container(
                      height: 70,
                      decoration: section.image.isNotEmpty
                          ? BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(section.image),
                                  fit: BoxFit.cover))
                          : BoxDecoration(),
                    )
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
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.productsScreen,
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
                          child: Container(
                            width: getProportionateScreenWidth(250),
                            height: getProportionateScreenHeight(70),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppKeys.viewAll.tr,
                                  style: AppFonts.heading2.copyWith(
                                      color: AppColors.black,
                                      fontSize: getResponsiveFontSize(18),
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(Icons.arrow_forward_rounded)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        : Container(

          );
  }
}
