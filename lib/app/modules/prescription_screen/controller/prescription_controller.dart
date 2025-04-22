import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/prescription_entity.dart';
import '../../../domain/usecases/upload_prescription_usecase.dart';
import '../../../core/errors/failure.dart';
import '../../../routes/app_routes.dart';

class AddPrescriptionController extends GetxController {
  final UploadPrescriptionUseCase uploadPrescriptionUseCase;

  AddPrescriptionController(this.uploadPrescriptionUseCase);

  var formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var selectedImagePath = ''.obs;

  final aboutImageController = TextEditingController();
  final orderProductNamesController = TextEditingController();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> uploadPrescription() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedImagePath.value.isEmpty &&
        orderProductNamesController.text.isEmpty) {
      Get.snackbar("Error".tr, "Please enter Prescription".tr);
      return;
    }

    isLoading.value = true;

    final result = await uploadPrescriptionUseCase(
      filePath: selectedImagePath.value,
      aboutImage: aboutImageController.text.trim(),
      orderProductNames: orderProductNamesController.text.trim(),
    );

    result.fold(
      (Failure failure) {
        Get.snackbar("Error", failure.message);
      },
      (PrescriptionEntity entity) {
        Get.offNamed(AppRoutes.prescriptionCompletedScreen);
      },
    );

    isLoading.value = false;
  }

  @override
  void onClose() {
    aboutImageController.dispose();
    orderProductNamesController.dispose();
    super.onClose();
  }
}
