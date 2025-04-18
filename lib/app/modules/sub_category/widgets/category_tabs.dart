import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../domain/entities/category_entity.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.selectedColor = Colors.white,
    this.backgroundColor = Colors.white,
  });

  final List<CategoryEntity> items;
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                label: Text(
                  items[index].name,
                  style: AppFonts.heading3.copyWith(
                    fontSize: 14,
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.withOpacity(.6),
                  ),
                ),
                selected: isSelected,
                selectedColor: selectedColor,
                backgroundColor: isSelected
                    ? backgroundColor
                    : AppColors.grey.withOpacity(.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.grey.withOpacity(.1),
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
