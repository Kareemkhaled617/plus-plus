import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';


class ProductBenefitItem extends StatelessWidget {
  const ProductBenefitItem({super.key, required this.text});
  final String text ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 6, color: AppColors.greyWithShade.withOpacity(.5)),
          SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: AppFonts.bodyText.copyWith(
                    fontSize: 14,
                    color: AppColors.greyWithShade.withOpacity(.5))),
          ),
        ],
      ),
    ) ;
  }
}
