import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/screen/cart/widget/cart_empty_body.dart';
import 'package:plus/screen/cart/widget/cart_list_item.dart';
import 'package:plus/screen/cart/widget/checkout_summary.dart';
import 'package:plus/screen/cart/widget/related_products_list.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';
import 'package:plus/utils/app_keys.dart';

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
                        style: AppFonts.heading1,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CartListItem(),
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
