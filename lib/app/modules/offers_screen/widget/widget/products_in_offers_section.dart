import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/product_details_screen/product_details_screen.dart';

import '../../../../../generated/assets.dart';
import '../../../../core/widgets/product_item.dart';

class ProductsInOffersSection extends StatelessWidget {
  const ProductsInOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.to(const ProductDetailsScreen());
              },
              child: ProductCard(
                isOffer: true,
                imageUrl: Assets.tempDsd,
                title: "Evy Baby",
                stockInfo: "Suncream",
                price: "45 L.E",
                onFavorite: () {},
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.to(const ProductDetailsScreen());
              },
              child: ProductCard(
                isOffer: true,
                imageUrl: Assets.tempDsd,
                title: "Evy Baby",
                stockInfo: "Suncream",
                price: "45 L.E",
                onAddToCart: () {},
                onFavorite: () {},
              ),
            ),
          ),
        )
      ],
    );
  }
}
