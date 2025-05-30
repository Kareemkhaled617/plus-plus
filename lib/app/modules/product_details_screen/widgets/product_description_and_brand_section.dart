import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_brand_item.dart';
import 'package:plus/app/modules/product_details_screen/widgets/product_description_tab.dart';

import '../../../core/theme/app_colors.dart';

class ProductDescriptionAndBrandSection extends StatefulWidget {
  const ProductDescriptionAndBrandSection(
      {super.key,});



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
          dividerColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: "Product Description".tr),
            Tab(text: "Brand".tr),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.43,
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
