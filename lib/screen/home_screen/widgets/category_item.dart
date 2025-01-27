import 'package:flutter/material.dart';
import 'package:plus/utils/app_colors.dart';

class CategoryGrid extends StatelessWidget {
  final List<Map<String, String>> categories;

  const CategoryGrid({
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
          childAspectRatio: 1.4,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Image.asset(category['imageUrl']!, fit: BoxFit.contain),
                ),
              ),
              SizedBox(height: 8),
              Text(
                category['title']!,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
