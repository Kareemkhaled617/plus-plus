import 'package:flutter/material.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_benefit_item.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class ProductDescriptionTab extends StatelessWidget {
  const ProductDescriptionTab ({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "La ROCHE-POSAY",
            style: AppFonts.heading1.copyWith(fontSize: 14),
          ),
          Text(
            "face wash gel",
            style: AppFonts.heading1
                .copyWith(fontSize: 14, color: AppColors.primary),
          ),
          SizedBox(height: 8),
          // Description

          Text(
            "Contributes to a range of functions within the body thanks to Chemist Direct Zinc! With 15 mg of Zinc to support fertility, vision, the immune system, and cognitive function. Suitable for vegetarians and vegans. Free from Nuts, Gluten, and Soya.",
            style: TextStyle(fontSize: 14, color: AppColors.greyWithShade.withOpacity(.5)),
          ),
          SizedBox(height: 16),
          Text(
            "Benefits",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ProductBenefitItem(text: "Clinical compatibility."),
          ProductBenefitItem(text: "Clinical compatibility."),
          ProductBenefitItem(text: "Clinical compatibility."),
        ],
      ),
    );
  }
}
