import 'package:get/get.dart';
import 'package:plus/app/data/repositories/account_repository_impl.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import '../../../domain/usecases/verify_phone_use_case.dart';
import '../controller/otp_controller.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = ApiService();
    final repository = AuthRepositoryImpl(apiService);
    final accountRepository = AccountRepositoryImpl(apiService);
    final useCase = VerifyOtpUseCase(repository);
    final useCasePhone = VerifyPhoneUseCase(accountRepository);

    Get.lazyPut<OTPController>(() => OTPController(useCase, useCasePhone));
  }
}
