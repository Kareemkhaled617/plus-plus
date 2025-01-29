import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/utils/app_colors.dart';

import '../../../utils/app_fonts.dart';

class SpecialBrand extends StatelessWidget {
  final List<Map<String, String>> categories;

  const SpecialBrand({
    required this.categories,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 1.3,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Image.asset(category['imageUrl']!, fit: BoxFit.contain),
            ),
          );
        },
      ),
    );
  }
}
