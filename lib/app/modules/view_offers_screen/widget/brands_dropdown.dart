import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../domain/entities/brand_entity.dart';
import '../../offers_screen/controller/offer_controller.dart';
import '../controller/product_offer_controller.dart';

class BrandsDropdown extends StatefulWidget {
  const BrandsDropdown({super.key});

  @override
  State<BrandsDropdown> createState() => _BrandsDropdownState();
}

class _BrandsDropdownState extends State<BrandsDropdown> {
  BrandEntity? selectedValue;
  final OfferController controller = Get.find<OfferController>();
  final ProductOffersController productOffersController =
      Get.find<ProductOffersController>();

  @override
  void initState() {
    selectedValue = controller.brands.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<BrandEntity>(
          value: selectedValue,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent),
          isExpanded: true,
          style: AppFonts.heading3,
          dropdownColor: AppColors.white,
          items: controller.brands
              .map((BrandEntity value) => DropdownMenuItem(
                    value: value,
                    child: Text(value.name),
                  ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue!;
            });
            productOffersController.fetchProductsByOfferAndBrand(
                Get.arguments['offerId'], newValue!.id);
          },
        ),
      ),
    );
  }
}
