import 'package:flutter/material.dart';
import 'package:plus/utils/app_fonts.dart';

import '../../../utils/app_colors.dart';

class ProductTypesSection extends StatefulWidget {
  const ProductTypesSection({super.key});

  @override
  State<ProductTypesSection> createState() => _ProductTypesSectionState();
}

class _ProductTypesSectionState extends State<ProductTypesSection> {
  final choices = ["Package", "Stripe","Ampoule"];
  String selected = "Package"; // This should be mutable

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: choices.map((choice) {
        return RadioMenuButton<String>(
          value: choice,
          groupValue: selected,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selected = value;
              });
            }
          },
          toggleable: false, // Set to false if you want it to act as a traditional radio button (single selection)
          child: Text(choice,style: AppFonts.heading3.copyWith(
            fontSize: 14,
            color: selected == choice ? AppColors.black : Colors.grey.shade600,
          ),),
        );
      }).toList(),
    );
    ;
  }
}
