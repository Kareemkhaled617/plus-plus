import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../../utils/app_keys.dart';

class ProductPriceSection extends StatelessWidget {
  const ProductPriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.grey.shade300.withOpacity(.5)),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "120 Tablets",
              style: AppFonts.heading3.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "${AppKeys.price}:  ",
                  style: AppFonts.heading3,
                  children: [
                    TextSpan(
                      text: "120 L.E",
                      style: AppFonts.heading3.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    )
                  ]
              ),
            ]))
          ],
        ),
        SizedBox(
          height: 12,
        ),  Divider(color: Colors.grey.shade300.withOpacity(.5)),

      ],
    );
  }
}
