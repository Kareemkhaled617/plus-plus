import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';


class ProductCounterSection extends StatefulWidget {
  const ProductCounterSection({super.key, this.plusIconSize = 20});

  final double? plusIconSize;

  @override
  State<ProductCounterSection> createState() => _ProductCounterSectionState();
}

class _ProductCounterSectionState extends State<ProductCounterSection> {
  int counter = 1;

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
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.remove,
                size: 20,
              ),
            ),
            onTap: () {
              if (counter > 1) {
                setState(() {
                  counter--;
                });
              }
            },
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            counter.toString(),
            style: AppFonts.heading2,
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              setState(() {
                counter++;
              });
            },
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: widget.plusIconSize,
              child: const Icon(
                Icons.add,
                size: 20,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
