import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.selectedColor = Colors.white,
    this.backgroundColor = Colors.white,
  });

  final List<String> items;
  final int selectedIndex;
  final Function(int) onSelected;
  final Color selectedColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          items.length,
              (index) {
            bool isSelected = index == selectedIndex;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ChoiceChip(
                showCheckmark: false,
                label: Text(
                  items[index],
                  style: AppFonts.heading3.copyWith(
                    fontSize: 14,
                    color: isSelected ? AppColors.primary : Colors.black,
                  ),
                ),
                selected: isSelected,
                selectedColor: selectedColor,
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.grey.withOpacity(0.3),
                  ),
                ),
                onSelected: (selected) => onSelected(index),
              ),
            );
          },
        ),
      ),
    );
  }
}