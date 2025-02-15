import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import 'dotted_border_painter.dart';

class UploadPrescriptionWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const UploadPrescriptionWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap for image upload
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(
          painter: DottedBorderPainter(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor:Color(0xff2A62FF).withOpacity(0.1),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                SizedBox(height: 12,),
                const SizedBox(height: 8),
                Text(
                  AppKeys.uploadPrescription.tr,
                  style: AppFonts.hintText.copyWith(fontSize: 10)
                ),
                SizedBox(height: 12,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
