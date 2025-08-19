import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/domain/entities/product_entity.dart';
import 'package:plus/app/modules/cart/controller/cart_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class ProductCounterSection extends StatefulWidget {
  const ProductCounterSection(
      {super.key,
      this.plusIconSize = 20,
      this.isSelected = false,
      required this.controller,
      required this.productEntity});

  final double? plusIconSize;
  final ProductEntity productEntity;
  final CartController controller;
  final bool? isSelected;

  @override
  State<ProductCounterSection> createState() => _ProductCounterSectionState();
}

class _ProductCounterSectionState extends State<ProductCounterSection> {
  int counter = 0;

  @override
  void initState() {
    counter = widget.controller.getProductCount(widget.productEntity.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightLavender,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.remove,
                size: 15,
              ),
            ),
            onTap: () {
              widget.controller.removeFromCart(widget.productEntity.id);
              widget.controller.addToCartApi();
            },
          ),
          SizedBox(
            width: 10,
          ),
          Obx(() {
            return Text(
              widget.controller
                  .getProductCount(widget.productEntity.id)
                  .toString(),
              style: AppFonts.heading2,
            );
          }),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              widget.controller.addToCart(widget.productEntity,
                  isSelect: widget.isSelected!);
              widget.controller.addToCartApi();
            },
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: widget.plusIconSize,
              child: const Icon(
                Icons.add,
                size: 15,
                color: AppColors.white,
              ),
            ),
          ),
        ],
        ));
  }
}
