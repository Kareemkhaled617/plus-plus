import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../data/models/package_type_model.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/product_controller.dart';

class ProductTypesSection extends StatefulWidget {
  const ProductTypesSection({super.key, required this.controller});

  final ProductDetailsController controller;

  @override
  State<ProductTypesSection> createState() => _ProductTypesSectionState();
}

class _ProductTypesSectionState extends State<ProductTypesSection> {
  CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.isSelected.value = cartController.isProductSelected(
          widget.controller.product.value!.id); // ✅ Call your function here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.controller.product.value!.packageTypes.map((choice) {
          return CheckboxListTile(
            value: widget.controller.isSelected.value,
            onChanged: (value) {
              widget.controller.selected.value = choice;
              widget.controller.isSelected.value = value!;
              cartController.updateProductSelection(
                  widget.controller.product.value!.id, value);
            },
            title: Row(
              children: [
                Text(
                  choice.unitType.toUpperCase(),
                  style: AppFonts.heading3.copyWith(
                    fontSize: 14,
                    color: widget.controller.isSelected.value
                        ? AppColors.black
                        : Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  choice.unitPrice.toString(),
                  style: AppFonts.heading3.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: widget.controller.isSelected.value
                        ? AppColors.black
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primary,
            dense: true,
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      );
    });
  }
}
