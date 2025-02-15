import 'package:flutter/material.dart';

import '../../../../components/product_item.dart';
import '../../../../generated/assets.dart';

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
            itemBuilder: (context, index) => ProductCard(
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
        SizedBox(height: 20,),
        SizedBox(
          height: MediaQuery.of(context).size.height * .4,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) => ProductCard(
              isOffer: true,
              imageUrl: Assets.tempDsd,
              title: "Evy Baby",
              stockInfo: "Suncream",
              price: "45 L.E",
              onAddToCart: () {},
              onFavorite: () {},
            ),
          ),
        )
      ],
    );
  }
}
