import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/sub_category/widgets/category_tabs.dart';

import '../../../generated/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/widgets/app_bar_back_button.dart';
import '../../core/widgets/product_item.dart';
import '../product_details_screen/product_details_screen.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key, required this.title});

  final String title;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  int _selectedCategory = 0;
  int _selectedSubcategory = 0;

  final List<String> categories = [
    "ALL",
    "Diapers and cosmetics",
    "Mother care"
  ];

  final Map<int, List<String>> subcategories = {
    0: [],
    1: ["Diapers", "Lotions", "Powders"],
    2: ["Feeding", "Bathing", "Clothing"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          widget.title,
          style: AppFonts.heading3,
        ),
        leading: AppBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            CategoryTabs(
              items: categories,
              selectedIndex: _selectedCategory,
              onSelected: (index) {
                setState(() {
                  _selectedCategory = index;
                  _selectedSubcategory = 0;
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
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => ProductDetailsScreen(),
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      child: ProductCard(
                        imageUrl: Assets.tempDsd,
                        title: "Evy Baby",
                        stockInfo: "Suncream",
                        price: "45 L.E",
                        onAddToCart: () {},
                        onFavorite: () {},
                      ),
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
