import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/cart/widget/cart_empty_body.dart';
import 'package:plus/app/modules/cart/widget/cart_list_item.dart';
import 'package:plus/app/modules/cart/widget/checkout_summary.dart';
import 'package:plus/app/modules/cart/widget/related_products_list.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static final products = [
    {
      'name': 'Nivea',
      'price': 10.0,
      'quantity': 2,
    },
    {
      'name': 'Dettol',
      'price': 20.0,
      'quantity': 1,
    },
    {
      'name': 'LA ROCHE-POSAY',
      'price': 15.0,
      'quantity': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return products.isNotEmpty
        ? Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      RelatedProductsList(relatedProducts: products),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppKeys.cartProducts.tr,
                        style: AppFonts.heading1.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: [
                          CartListItem(),
                          SizedBox(height: 20,),
                          CartListItem(),
                        ],
                      ),
                      SizedBox(height: 16),
                      CheckoutSummary(),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const CartEmptyBody();
  }
}
