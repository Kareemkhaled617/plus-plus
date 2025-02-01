import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/components/app_bar_back_button.dart';
import 'package:plus/components/custom_text_form_field.dart';
import 'package:plus/generated/assets.dart';
import 'package:plus/screen/prescription_screen/widgets/upload_prescription_widget.dart';
import 'package:plus/utils/app_keys.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../prescription_completed/prescription_completed_screen.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(AppKeys.prescription.tr, style: AppFonts.heading3),
        leading: AppBarBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque ,
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              children: [
                SizedBox(height: 25),
                Image.asset(
                  Assets.iconsPrescription,
                  width: 124,
                ),
                SizedBox(height: 30),
                UploadPrescriptionWidget(
                  onTap: () {

                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: AppKeys.aboutThePhoto.tr,
                  controller: TextEditingController(),
                  keyboardType: TextInputType.multiline,
                  isMaxLines: true,
                  hintStyle: AppFonts.hintText
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  fillColor: Colors.grey.withOpacity(.1),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300, // Light grey line
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppKeys.or.tr,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xff2A62FF).withOpacity(0.1),
                  child: Image.asset(
                    Assets.iconsPin,
                    width: 18,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  AppKeys.typeYourOrder.tr,
                  style: AppFonts.heading3.copyWith(fontSize: 10),
                ),
                SizedBox(height: 12),
                Text(
                  AppKeys.typeYourOrderHint.tr,
                  style: AppFonts.hintText.copyWith(fontSize: 10),
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  hintText: AppKeys.aboutThePhoto.tr,
                  controller: TextEditingController(),
                  keyboardType: TextInputType.multiline,
                  isMaxLines: true,
                  hintStyle: AppFonts.hintText
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  fillColor: Colors.grey.withOpacity(.1),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    minimumSize: Size(180, 43),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.to(PrescriptionCompletedScreen());
                  },
                  child: Text(
                    AppKeys.submit.tr,
                    style: AppFonts.heading3.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
