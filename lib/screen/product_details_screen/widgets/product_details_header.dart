import 'package:flutter/material.dart';

import '../../../components/app_bar_back_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

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
        // Discount percent
        Stack(
          children: [
            Icon(
              Icons.bookmark,
              color: AppColors.deepRed,
              size: 35,
            ),
            Positioned(
              top: 10,
              right: 12,
              child: Text(
                "-10",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(4),
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
