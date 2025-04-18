import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/modules/access_location/controller/location_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';

class DestinationSelection extends StatefulWidget {
  const DestinationSelection({super.key});

  @override
  State<DestinationSelection> createState() => _SetAsSelectionState();
}

class _SetAsSelectionState extends State<DestinationSelection> {
  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppKeys.setAs.tr,
          style: AppFonts.heading1.copyWith(fontSize: 14),
        ),
        SizedBox(height: 12),
        Obx(() {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: locationController.options.map((option) {
                bool isSelected =
                    locationController.selectedOption.value == option;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      locationController.selectedOption.value = option;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            isSelected ? AppColors.black : Colors.grey.shade300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      option,
                      style: AppFonts.bodyText.copyWith(
                        color: isSelected ? AppColors.black : AppColors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }
}
