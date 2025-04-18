import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../domain/entities/point_entity.dart';
import '../../../domain/usecases/change_language_usecase.dart';
import '../../../domain/usecases/get_account_points_usecase.dart';
import '../../../domain/usecases/update_account_usecase.dart';

class AccountController extends GetxController {
  final UpdateAccountUseCase updateAccountUseCase;
  final GetAccountPointsUseCase getAccountPointsUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;

  AccountController(this.updateAccountUseCase, this.getAccountPointsUseCase,
      this.changeLanguageUseCase);

  final isLoading = false.obs;
  final isLoadingP = false.obs;
  final points = 0.obs;
  RxBool isChangingLang = false.obs;
  TextEditingController nameController = TextEditingController();

  RxList<PointEntity> pointsList = <PointEntity>[].obs;

  Future<void> updateAccount() async {
    if (nameController.text.isEmpty) {
      Get.snackbar("Error".tr, "Please enter your name.".tr);
      return;
    }

    isLoading.value = true;
    final result = await updateAccountUseCase(nameController.text.trim());
    isLoading.value = false;

    if (result) {
      Get.back();
      Get.snackbar("Success".tr, "Updated successfully!".tr);
    } else {
      Get.snackbar("Error".tr, "An error occurred while updating.".tr);
    }
  }

  Future fetchPoints() async {
    isLoadingP.value = true;

    final pointData = await getAccountPointsUseCase();
    pointsList.value = pointData.points;
    points.value = pointData.userPoints;
    isLoadingP.value = false;
    return pointData;
  }

  Future<void> changeLanguage(String locale) async {
    isChangingLang.value = true;
    final result = await changeLanguageUseCase(locale);
    isChangingLang.value = false;

    if (result) {
      Get.snackbar("Success".tr, "Language updated successfully!".tr);
    } else {
      Get.snackbar("Error".tr, "Failed to update language.".tr);
    }
  }
}
