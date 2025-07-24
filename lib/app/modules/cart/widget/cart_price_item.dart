import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class CartPriceItem extends StatelessWidget {
  const CartPriceItem({super.key, required this.title, required this.price, this.isTotal  = false});
  final String title;
  final String price;
  final bool? isTotal ;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppFonts.heading3
        ),
        Text(
          price,
          style: AppFonts.heading3.copyWith(
            color: AppColors.black
          ),
        ),
      ],
    );
  }
}
