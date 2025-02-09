import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../../utils/app_keys.dart';
import '../../product_details_screen/widgets/product_counter_section.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.greyWithShade.withOpacity(.3),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Assets.tempCream,
                width: 100,
                height: 144,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "La ROCHE-POSAY",
                    style: AppFonts.heading1.copyWith(fontSize: 14),
                  ),
                  Text(
                    "face wash gel",
                    style: AppFonts.heading1
                        .copyWith(fontSize: 12, color: AppColors.red),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        "1 ${AppKeys.peace.tr}",
                        style: AppFonts.heading1.copyWith(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(width: 100),
                      Text(
                        "250 L.E",
                        style: AppFonts.heading1
                            .copyWith(fontSize: 12, color: AppColors.red),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ProductCounterSection(plusIconSize: 16),
                      SizedBox(width: 4),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {

            },
            child: Container(
              padding: EdgeInsets.only(left: 6, top: 6, right: 6, bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10),
                    bottomStart: Radius.circular(10)),
                color: AppColors.primary,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
