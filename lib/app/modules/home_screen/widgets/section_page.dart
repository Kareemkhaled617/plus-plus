import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/home_screen/widgets/product_section.dart';
import 'package:plus/app/modules/home_screen/widgets/special_brands.dart';

import '../../../core/utils/shimmer.dart';
import '../controller/section_controller.dart';

class SectionPage extends StatelessWidget {
  const SectionPage({super.key});

  bool _isProducts(String? t) => (t ?? '').toLowerCase().contains('product');

  bool _isBrands(String? t) => (t ?? '').toLowerCase().contains('brand');

  @override
  Widget build(BuildContext context) {
    final sectionController = Get.find<SectionController>();

    return Obx(() {
      if (sectionController.isLoading.value) {
        return shimmerBox(height: 20, width: 150);
      }

      final sections = sectionController.sections;

      // 1) split sections
      final productSections =
          sections.where((s) => _isProducts(s.sectionType)).toList();

      // treat any section explicitly typed as "brand(s)" OR a product section that actually has brands[]
      final brandSections = sections.where((s) {
        final hasBrandsArray = (s.brands != null && s.brands.isNotEmpty);
        return _isBrands(s.sectionType) || hasBrandsArray;
      }).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // A) render ALL product sections first
          ...productSections.map((sec) => ProductSection(section: sec)),

          // B) render ALL brand sections after products
          ...brandSections.map((sec) => SpecialBrand(section: sec)),
        ],
      );
    });
  }
}
