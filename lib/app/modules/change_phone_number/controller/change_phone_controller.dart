import 'package:get/get.dart';

import '../../../domain/usecases/update_phone_number_usecase.dart';
import '../../../routes/app_routes.dart';

class ChangePhoneController extends GetxController {
  final UpdatePhoneNumberUseCase updatePhoneNumberUseCase;

  ChangePhoneController(this.updatePhoneNumberUseCase);

  final phoneNumber = ''.obs;
  final isLoading = false.obs;

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }

  Future<void> updatePhone() async {
    print(phoneNumber.value);
    if (phoneNumber.value.isEmpty) {
      Get.snackbar("Error".tr, "Please enter a valid phone number".tr);
      return;
    }

    isLoading.value = true;

    final result =
        await updatePhoneNumberUseCase(phoneNumber.value.replaceFirst('+', ''));

    result.fold(
      (failure) => Get.snackbar("Error".tr, failure.message),
      (entity) {
        Get.snackbar("Success".tr, entity.message);
        Get.toNamed(AppRoutes.otp,
            arguments: {"phone": phoneNumber.value, 'is_new_user': false});
      },
    );

    isLoading.value = false;
  }
}
