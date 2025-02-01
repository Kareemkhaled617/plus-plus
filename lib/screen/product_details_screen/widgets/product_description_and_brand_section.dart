import 'package:flutter/material.dart';
import 'package:plus/screen/product_details_screen/widgets/product_benefit_item.dart';
import 'package:plus/screen/product_details_screen/widgets/product_brand_item.dart';
import 'package:plus/screen/product_details_screen/widgets/product_description_tab.dart';
import 'package:plus/utils/app_colors.dart';

import '../../../utils/app_fonts.dart';

class ProductDescriptionAndBrandSection extends StatefulWidget {
  const ProductDescriptionAndBrandSection({super.key});

  @override
  State<ProductDescriptionAndBrandSection> createState() => _ProductTabsState();
}

class _ProductTabsState extends State<ProductDescriptionAndBrandSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ), // Optional rounded corners for the indicator(8),
          ),
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: "Product Description"),
            Tab(text: "Brand"),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: MediaQuery.of(context).size.height *
              0.4, // Set height to prevent overflow
          child: TabBarView(
            controller: _tabController,
            children: [
              ProductDescriptionTab(),
              ProductBrandItem(),
            ],
          ),
        ),
      ],
    );
  }

}
