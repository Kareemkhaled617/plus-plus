import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/core/widgets/brands_list_item.dart';
import 'package:plus/app/core/widgets/loader.dart';

import '../../../generated/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/widgets/custom_text_form_field.dart';
import 'controller/brand_controller.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BrandController controller = Get.find<BrandController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          AppKeys.brands.tr,
          style: AppFonts.heading1,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        flexibleSpace: Container(
          color: AppColors.white,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            // CustomTextFormField(
            //   hintText: AppKeys.searchForBrand.tr,
            //   controller: TextEditingController(),
            //   keyboardType: TextInputType.text,
            //   prefixIcon: Image.asset(Assets.iconsSearch),
            // ),
            SizedBox(
              height: 12,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: AppLoader());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              } else {
                return Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 30.0,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: controller.brands.length,
                    itemBuilder: (context, index) {
                      final brand = controller.brands[index];
                      return BrandsListItem(brand: brand);
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
