import 'package:flutter/material.dart';
import 'package:plus/screen/sub_category/widgets/category_tabs.dart';
import 'package:plus/utils/app_colors.dart';

import '../../components/app_bar_back_button.dart';
import '../../components/product_item.dart';
import '../../generated/assets.dart';
import '../../utils/app_fonts.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  int _selectedCategory = 0;
  int _selectedSubcategory = 0;

  // Main Categories
  final List<String> categories = [
    "ALL",
    "Diapers and cosmetics",
    "Mother care"
  ];

  // Subcategories for each category
  final Map<int, List<String>> subcategories = {
    0: [], // For ALL
    1: ["Diapers", "Lotions", "Powders"], // For "Diapers and cosmetics"
    2: ["Feeding", "Bathing", "Clothing"], // For "Mother care"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Baby Care",
          style: AppFonts.heading3,
        ),
        leading: AppBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            // Categories Widget
            CategoryTabs(
              items: categories,
              selectedIndex: _selectedCategory,
              onSelected: (index) {
                setState(() {
                  _selectedCategory = index;
                  _selectedSubcategory = 0; // Reset subcategory on change
                });
              },
            ),
            const SizedBox(height: 10),
            // Subcategories Widget
            CategoryTabs(
              items: subcategories[_selectedCategory] ?? [],
              selectedIndex: _selectedSubcategory,
              onSelected: (index) {
                setState(() {
                  _selectedSubcategory = index;
                });
              },
              selectedColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            // PRODUCTS GRID
            SizedBox(height: 10),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    childAspectRatio: .65,
                  ),
                  itemCount: 10, // Adjust count dynamically
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imageUrl: Assets.tempDsd,
                      title: "Evy Baby",
                      stockInfo: "Suncream",
                      price: "45 L.E",
                      onAddToCart: () {},
                      onFavorite: () {},
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
