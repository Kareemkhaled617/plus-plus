import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/privacy_policy_repository_impl.dart';
import '../../../domain/repositories/privacy_policy_repository.dart';
import '../../../domain/usecases/get_privacy_policy_usecase.dart';
import '../controller/privacy_policy_controller.dart';

class PrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<PrivacyPolicyRepository>(() =>
        PrivacyPolicyRepositoryImpl(Get.find<ApiService>()));
    Get.lazyPut<GetPrivacyPolicyUseCase>(() =>
        GetPrivacyPolicyUseCase(Get.find<PrivacyPolicyRepository>()));
    Get.put(PrivacyPolicyController(Get.find<GetPrivacyPolicyUseCase>()));
  }
}
