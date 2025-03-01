import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';



class ShippingDetailsSection extends StatelessWidget {
  const ShippingDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppKeys.shippingDetails.tr, style: AppFonts.heading3),
        SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppColors.greyWithShade.withOpacity(.2))),
          child: ListTile(
            leading: Icon(Icons.home, color: Colors.orange),
            title: Text(
              AppKeys.home.tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Cairo, El-Gash street build 4"),
          ),
        ),
      ],
    );
  }
}
