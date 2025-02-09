import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class ShippingDetailsSection extends StatelessWidget {
  const ShippingDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Shipping details", style: AppFonts.heading3),
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
              "Home",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Cairo, El-Gash street build 4"),
          ),
        ),
      ],
    );
  }
}
