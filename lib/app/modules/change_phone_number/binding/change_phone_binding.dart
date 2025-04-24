import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/account_repository_impl.dart';
import '../../../domain/repositories/account_repository.dart';
import '../../../domain/usecases/update_phone_number_usecase.dart';
import '../controller/change_phone_controller.dart';

class ChangePhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(Get.find<ApiService>()));
    Get.lazyPut(() => UpdatePhoneNumberUseCase(Get.find<AccountRepository>()));
    Get.put(ChangePhoneController(Get.find<UpdatePhoneNumberUseCase>()));
  }
}
