import 'package:get/get.dart';
import '../../../core/network/api_service.dart';

import '../../../data/repositories/business_settings_repository_impl.dart';
import '../../../domain/repositories/business_settings_repository.dart';
import '../../../domain/usecases/get_business_settings_usecase.dart';
import '../controller/business_settings_controller.dart';

class BusinessSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<BusinessSettingsRepository>(
        () => BusinessSettingsRepositoryImpl(Get.find()));
    Get.lazyPut(() =>
        GetBusinessSettingsUseCase(Get.find<BusinessSettingsRepository>()));
    Get.lazyPut(() =>
        BusinessSettingsController(Get.find<GetBusinessSettingsUseCase>()));
  }
}
