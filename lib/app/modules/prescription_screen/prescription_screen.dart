import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/prescription_screen/widgets/upload_prescription_widget.dart';

import '../../../generated/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../core/widgets/app_bar_back_button.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../core/widgets/loader.dart';

import 'controller/prescription_controller.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddPrescriptionController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(AppKeys.prescription.tr, style: AppFonts.heading2),
        leading: const AppBarBackButton(),
        elevation: 0,
        flexibleSpace: Container(
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Image.asset(Assets.iconsPrescription, width: 124),
                  const SizedBox(height: 30),
                  UploadPrescriptionWidget(onTap: controller.pickImage),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: AppKeys.aboutThePhoto.tr,
                    controller: controller.aboutImageController,
                    keyboardType: TextInputType.multiline,
                    isMaxLines: true,
                    validator: (value) {
                      if ((value == null || value.isEmpty) &&
                          controller.selectedImagePath.isNotEmpty) {
                        return AppKeys.requiredField.tr;
                      }
                      return null;
                    },
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                  const SizedBox(height: 20),
                  _buildDividerWithOr(),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Image.asset(Assets.iconsPin, width: 18),
                  ),
                  const SizedBox(height: 18),
                  Text(AppKeys.typeYourOrder.tr, style: AppFonts.heading3),
                  const SizedBox(height: 12),
                  Text(AppKeys.typeYourOrderHint.tr, style: AppFonts.hintText),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: 'Ex: Panadol',
                    controller: controller.orderProductNamesController,
                    keyboardType: TextInputType.multiline,
                    isMaxLines: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                  const SizedBox(height: 30),
                  Obx(() => CustomButton(
                        text: AppKeys.submit.tr,
                        isEnabled: !controller.isLoading.value,
                        onPressed: controller.isLoading.value
                            ? () {}
                            : controller.uploadPrescription,
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDividerWithOr() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(AppKeys.or.tr),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }
}
