import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/product_item.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../../utils/app_keys.dart';

class RelatedProductsList extends StatelessWidget {
  const RelatedProductsList({super.key, required this.relatedProducts});
  final List<dynamic> relatedProducts ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppKeys.relatedProducts.tr,
              style: AppFonts.heading2,
            ),
            Spacer(),
            Text(
              AppKeys.viewAll.tr,
              style: AppFonts.bodyText.copyWith(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 16,),
        SizedBox(
          height: 300,
          child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ProductCard(
                imageUrl: Assets.tempDsd,
                title: "Evy Baby",
                stockInfo: "Suncream",
                price: "45 L.E",
                onAddToCart: () {},
                onFavorite: () {},
              )),
        )
      ],
    );
  }
}
