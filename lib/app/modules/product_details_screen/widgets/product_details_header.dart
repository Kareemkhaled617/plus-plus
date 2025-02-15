import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/widgets/app_bar_back_button.dart';
import '../../../core/widgets/offers_percent_widget.dart';


class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppBarBackButton(),
        SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "La ROCHE-POSAY",
              style: AppFonts.heading1.copyWith(fontSize: 17),
            ),
            Text(
              "face wash gel",
              style: AppFonts.heading1
                  .copyWith(fontSize: 15, color: AppColors.primary),
            ),
          ],
        ),
        OffersPercentWidget(percent: "-10",),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: AppColors.grey.withOpacity(.3),
                  width: 1,
                ),
              ),
              child: Icon(Icons.favorite_border, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
