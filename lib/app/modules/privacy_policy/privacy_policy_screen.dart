import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import 'controller/privacy_policy_controller.dart';

void showPrivacyPolicyBottomSheet(BuildContext context) {
  final controller = Get.find<PrivacyPolicyController>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (controller.policies.isEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.value.isNotEmpty
                      ? controller.errorMessage.value
                      : "No Privacy Policy Found".tr,
                  style: AppFonts.bodyText,
                ),
              );
            }

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Privacy Policy".tr,
                        style: AppFonts.heading2.copyWith(color: AppColors.primary),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close, color: AppColors.red),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: controller.policies.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final policy = controller.policies[index];
                        return _buildPolicyCard(policy.contentType, policy.content);
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
    },
  );
}

Widget _buildPolicyCard(String title, String content) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.grey.withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: AppFonts.heading3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          style: AppFonts.bodyText.copyWith(height: 1.5),
        ),
      ],
    ),
  );
}
