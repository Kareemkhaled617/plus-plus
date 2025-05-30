import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
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
    final controller = Get.find<AddPrescriptionController>();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.lightBlue.withOpacity(.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            dashPattern: [10, 5],
            strokeWidth: 2,
            color: AppColors.primary,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            radius: Radius.circular(20),
          ),
          child: Obx(() {
            if (controller.selectedImagePath.value.isEmpty) {
              return _buildEmptyState();
            } else {
              return _buildImagePreview(controller.selectedImagePath.value);
            }
          }),
        ),
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

      ],
    );
  }

  Widget _buildImagePreview(String path) {
    return path.toLowerCase().endsWith('.pdf')
        ? Column(
            children: [
              Icon(Icons.picture_as_pdf, size: 64, color: Colors.red),
              const SizedBox(height: 8),
              Text("PDF file selected".tr, style: AppFonts.bodyText),
            ],
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(path),
              width: 124,
              height: 124,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Text("Invalid image file");
              },
            ),
          );
  }
}
