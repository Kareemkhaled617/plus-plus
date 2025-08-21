import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:plus/app/routes/app_routes.dart';

import '../../../core/widgets/pupup_dialog.dart';
import '../../../domain/entities/point_entity.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../../domain/usecases/change_language_usecase.dart';
import '../../../domain/usecases/get_account_points_usecase.dart';
import '../../../domain/usecases/get_user_profile_usecase.dart';
import '../../../domain/usecases/update_account_usecase.dart';

class AccountController extends GetxController {
  final UpdateAccountUseCase updateAccountUseCase;
  final GetAccountPointsUseCase getAccountPointsUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;

  AccountController(this.updateAccountUseCase, this.getAccountPointsUseCase,
      this.changeLanguageUseCase, this.getUserProfileUseCase);

  final isLoading = false.obs;
  final isLoadingP = false.obs;
  final points = 0.obs;
  RxBool isChangingLang = false.obs;
  var isLoadingGetProfile = true.obs;
  var profile = Rxn<UserProfileEntity>();
  TextEditingController nameController = TextEditingController(text: '');

  RxList<PointEntity> pointsList = <PointEntity>[].obs;

  @override
  void onInit() {
    // if (!Get.arguments['from_login']) {
    fetchUserProfile();
    // }

    super.onInit();
  }

  Future<void> updateAccount() async {
    if (nameController.text.isEmpty) {
      // Get.snackbar("Error".tr, "Please enter your name.".tr);
      AppPopup.show(
        Get.context!,
        type: AppPopupType.error,
        title: "Error".tr,

        message: "Please enter your name.".tr,
        primaryText: 'Retry',
        onPrimary: () => Get.back(),
        onSecondary: () => Get.back(),
      );
      return;
    }

    isLoading.value = true;
    final result = await updateAccountUseCase(nameController.text.trim());
    isLoading.value = false;

    if (result) {
      if (Get.arguments['from_login']) {
        Get.toNamed(AppRoutes.landingScreen);
        Get.snackbar("Success".tr, "Updated successfully!".tr);
      } else {
        Get.back();
        Get.snackbar("Success".tr, "Updated successfully!".tr);
      }
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

  Future<void> fetchUserProfile() async {
    isLoadingGetProfile.value = true;
    final result = await getUserProfileUseCase();
    result.fold(
      (failure) => Get.snackbar("Error", failure.message),
      (userData) {

        profile.value = userData;
        nameController.text = userData.name == "N/A" ? '' : userData.name;
      },
    );
    isLoadingGetProfile.value = false;
  }
}
