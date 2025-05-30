import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/size_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../controller/check_out_controller.dart';

class PaymentOptionsSection extends StatelessWidget {
  const PaymentOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();


    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppKeys.selectPayment.tr,
            textAlign: TextAlign.start,
            style: AppFonts.heading2,
          ),
          const SizedBox(height: 12),
          ...List.generate(controller.options.length, (index) {
            final isSelected = controller.selectedIndex.value == index;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: GestureDetector(
                onTap: () => controller.selectOption(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color:
                          isSelected ? AppColors.primary : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: index,
                        groupValue: controller.selectedIndex.value,
                        onChanged: (val) => controller.selectOption(index),
                        activeColor: Colors.deepPurple,
                      ),
                      Image.asset(
                        controller.images[index],
                        width: getProportionateScreenWidth(30),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          controller.options[index].tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? AppColors.primary : AppColors.grey,
                          ),
                        ),
                      ),
                      if (index == 2)
                        Icon(
                          controller.showCardDetails.value
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        )
                    ],
                  ),
                ),
              ),
            );
          }),
          if (controller.showCardDetails.value) ...[
            const SizedBox(height: 12),
            // _buildCardForm(),
          ],
        ],
      );
    });
  }

  // Widget _buildCardForm() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(16),
  //     margin: const EdgeInsets.symmetric(horizontal: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.grey.shade50,
  //       border: Border.all(color: Colors.deepPurple),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: const [
  //         Text("Card Number".),
  //         SizedBox(height: 8),
  //         TextField(
  //           decoration: InputDecoration(
  //             hintText: "Enter card number",
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //         SizedBox(height: 12),
  //         Text("Card Holder Name"),
  //         SizedBox(height: 8),
  //         TextField(
  //           decoration: InputDecoration(
  //             hintText: "Enter name",
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


}
