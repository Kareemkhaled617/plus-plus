import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../routes/app_routes.dart';


class CartDeliverySection extends StatelessWidget {
  const CartDeliverySection({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.addressDirectory);
      },
      child: Column(
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
              color: AppColors.babyBlue.withOpacity(.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Image.asset(Assets.iconsHome,width: 30,height: 30,),
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
      ),
    );
  }
}
