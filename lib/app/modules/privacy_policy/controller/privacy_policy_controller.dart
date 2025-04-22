import 'package:get/get.dart';
import '../../../domain/entities/privacy_policy_entity.dart';
import '../../../domain/usecases/get_privacy_policy_usecase.dart';

class PrivacyPolicyController extends GetxController {
  final GetPrivacyPolicyUseCase getPrivacyPolicyUseCase;

  PrivacyPolicyController(this.getPrivacyPolicyUseCase);

  var isLoading = false.obs;
  var policies = <PrivacyPolicyEntity>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchPrivacyPolicy();
    super.onInit();
  }

  void fetchPrivacyPolicy() async {
    isLoading.value = true;
    final result = await getPrivacyPolicyUseCase();

    result.fold(
          (failure) => errorMessage.value = failure.message,
          (data) => policies.assignAll(data),
    );
    isLoading.value = false;
  }
}
