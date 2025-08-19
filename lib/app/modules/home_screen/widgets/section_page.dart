import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/home_screen/widgets/product_section.dart';
import 'package:plus/app/modules/home_screen/widgets/special_brands.dart';

import '../../../core/utils/shimmer.dart';
import '../controller/section_controller.dart';

class SectionPage extends StatelessWidget {
  const SectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sectionController = Get.find<SectionController>();
    return Obx(() {
      if (sectionController.isLoading.value) {
        return shimmerBox(height: 20, width: 150);
      }

      return Column(
        children: [
          ...List.generate(sectionController.sections.length, (index) {
            final section = sectionController.sections[index];
            return section.sectionType == 'products'
                ? ProductSection(
                    section: section,
                  )
                : SpecialBrand(
                    section: section,
                  );
          })
        ],
      );
    });
  }
}
