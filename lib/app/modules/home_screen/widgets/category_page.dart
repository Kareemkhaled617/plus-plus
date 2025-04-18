import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/loader.dart';
import '../../../core/widgets/category_item.dart';
import '../controller/category_controller.dart';
import '../shimmer/catogory_shimmer.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return CategoryShimmer();
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      return CategoryGrid(categories: controller.categories);
    });
  }
}
