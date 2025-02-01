import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';

import '../../../utils/app_keys.dart';

class CartDeliverySection extends StatelessWidget {
  const CartDeliverySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          AppKeys.deliveryTo.tr,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.babyBlue.withOpacity(.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.home, color: Colors.orange, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    AppKeys.home.tr,
                    style: AppFonts.heading3,
                  ),
                  Text(
                    "Cairo, El-Gash street build 4",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.primary),
            ],
          ),
        ),
      ],
    );
  }
}
