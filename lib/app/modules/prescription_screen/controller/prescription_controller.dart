import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plus/app/core/theme/app_colors.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/prescription_entity.dart';
import '../../../domain/usecases/upload_prescription_usecase.dart';
import '../../../routes/app_routes.dart';
class AddPrescriptionController extends GetxController {
  final UploadPrescriptionUseCase uploadPrescriptionUseCase;

  AddPrescriptionController(this.uploadPrescriptionUseCase);

  var formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var selectedImagePath = ''.obs;
  var selectedImageType = ''.obs;

  final aboutImageController = TextEditingController();
  final orderProductNamesController = TextEditingController();

  Future<void> pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageType.value = 'image';
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      selectedImagePath.value = result.files.single.path!;
      selectedImageType.value = 'pdf';
      print(selectedImagePath.value);
      print(selectedImagePath.value.toLowerCase().endsWith('.pdf'));
      }
      }

  Future<void> showPickOptions() async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.primary,
              ),
              title: Text('Gallery'),
              onTap: () {
                Get.back();
                pickImage(source: ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: AppColors.primary,
              ),
              title: Text('Camera'),
              onTap: () {
                Get.back();
                pickImage(source: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.insert_drive_file,
                color: AppColors.primary,
              ),
              title: Text('Pick File'),
              onTap: () {
                Get.back();
                pickFile();
              },
            ),
          ],
        ),
      ),
    );
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
      filetype: selectedImageType.value,
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
