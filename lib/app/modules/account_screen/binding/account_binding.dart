import 'package:get/get.dart';
import 'package:plus/app/modules/account_screen/controller/account_controller.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/account_repository_impl.dart';
import '../../../domain/repositories/account_repository.dart';
import '../../../domain/usecases/change_language_usecase.dart';
import '../../../domain/usecases/get_account_points_usecase.dart';
import '../../../domain/usecases/update_account_usecase.dart'; // 👈 UseCase

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(Get.find()));

    // ✅ Add the UseCase binding
    Get.lazyPut(() => UpdateAccountUseCase(Get.find()));
    Get.lazyPut<GetAccountPointsUseCase>(
        () => GetAccountPointsUseCase(Get.find()));
    Get.lazyPut<ChangeLanguageUseCase>(() => ChangeLanguageUseCase(Get.find()));
    // ✅ Inject UseCase into Controller
    Get.lazyPut(() => AccountController(
        Get.find<UpdateAccountUseCase>(),
        Get.find<GetAccountPointsUseCase>(),
        Get.find<ChangeLanguageUseCase>()));
  }
}
