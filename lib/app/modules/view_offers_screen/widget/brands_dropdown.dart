import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class BrandsDropdown extends StatefulWidget {
  const BrandsDropdown({super.key});

  @override
  State<BrandsDropdown> createState() => _BrandsDropdownState();
}

class _BrandsDropdownState extends State<BrandsDropdown> {
  String selectedValue = "NIVEA";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent),
          style: AppFonts.heading3,
          dropdownColor: AppColors.white,
          items: ["NIVEA", "Dove", "L'Oreal", "Neutrogena"]
              .map((String value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
        ),
      ),
    );
  }
}
