import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:plus/app/core/theme/app_fonts.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/modules/all_prescription/controller/prescription_controller.dart';

import '../../core/utils/app_keys.dart';
import 'widget/prescription_card.dart';

class AllPrescriptionScreen extends StatelessWidget {
  const AllPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PrescriptionController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          color: AppColors.white,
        ),
        elevation: 0,
        leading: AppBarBackButton(),
        title: Text(
          AppKeys.allPrescriptions.tr,
          style: AppFonts.heading1.copyWith(fontSize: 20),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.prescriptions.isEmpty) {
          return Center(child: Text("No Prescriptions Found".tr));
        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: controller.prescriptions.length,
          itemBuilder: (context, index) {
            return PrescriptionCard(
                prescription: controller.prescriptions[index]);
          },
        );
      }),
    );
  }


}
