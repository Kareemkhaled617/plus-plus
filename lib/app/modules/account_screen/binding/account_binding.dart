import 'package:get/get.dart';
import 'package:plus/app/modules/account_screen/controller/account_controller.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/account_repository_impl.dart';
import '../../../domain/repositories/account_repository.dart';
import '../../../domain/usecases/change_language_usecase.dart';
import '../../../domain/usecases/get_account_points_usecase.dart';
import '../../../domain/usecases/get_user_profile_usecase.dart';
import '../../../domain/usecases/update_account_usecase.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    // ApiService is async now → use putAsync
    Get.putAsync<ApiService>(() async => await ApiService.create());

    // Repos & usecases (they resolve ApiService lazily from Get.find())
    Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(Get.find()),
        fenix: true);

    Get.lazyPut<UpdateAccountUseCase>(() => UpdateAccountUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<GetAccountPointsUseCase>(
        () => GetAccountPointsUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<ChangeLanguageUseCase>(() => ChangeLanguageUseCase(Get.find()),
        fenix: true);
    Get.lazyPut<GetUserProfileUseCase>(() => GetUserProfileUseCase(Get.find()),
        fenix: true);

    // Controller
    Get.lazyPut(
      () => AccountController(
        Get.find<UpdateAccountUseCase>(),
        Get.find<GetAccountPointsUseCase>(),
        Get.find<ChangeLanguageUseCase>(),
        Get.find<GetUserProfileUseCase>(),
      ),
      fenix: true,
    );
  }
}
