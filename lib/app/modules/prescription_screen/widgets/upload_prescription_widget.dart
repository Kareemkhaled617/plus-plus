import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../controller/prescription_controller.dart';

class UploadPrescriptionWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const UploadPrescriptionWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PrescriptionController>();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Obx(() {
          if (controller.selectedImagePath.value.isEmpty) {
            return _buildEmptyState();
          } else {
            return _buildImagePreview(controller.selectedImagePath.value);
          }
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary.withOpacity(0.08),
          child: Icon(Icons.add_a_photo_outlined, color: AppColors.primary),
        ),
        const SizedBox(height: 12),
        Text(AppKeys.uploadPrescription.tr, style: AppFonts.hintText),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildImagePreview(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        File(path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 150,
      ),
    );
  }
}
