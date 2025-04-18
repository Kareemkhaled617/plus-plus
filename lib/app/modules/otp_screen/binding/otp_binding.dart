import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import '../controller/otp_controller.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = ApiService();
    final repository = AuthRepositoryImpl(apiService);
    final useCase = VerifyOtpUseCase(repository);

    Get.lazyPut<OTPController>(() => OTPController(useCase));
  }
}
