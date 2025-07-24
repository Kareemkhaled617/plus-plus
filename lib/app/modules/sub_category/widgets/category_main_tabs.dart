import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../domain/entities/category_entity.dart';

class CategoryMainTabs extends StatelessWidget {
  const CategoryMainTabs({
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
            return InkWell(
              onTap: () => onSelected(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IntrinsicWidth(
                  child: Column(
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        style: AppFonts.heading2.copyWith(
                          fontSize: 16,
                          color:
                              isSelected ? AppColors.primary : AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Text(items[index].name),
                      ),
                      const SizedBox(height: 6),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
