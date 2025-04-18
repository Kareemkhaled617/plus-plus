import 'package:get/get.dart';

import '../core/network/api_service.dart';
import '../data/repositories/prescription_repository_impl.dart';
import '../domain/repositories/prescription_repository.dart';
import '../domain/usecases/upload_prescription_usecase.dart';
import '../modules/prescription_screen/controller/prescription_controller.dart';

class PrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = ApiService();
    final repository = PrescriptionRepositoryImpl(apiService);
    final useCase = UploadPrescriptionUseCase(repository);
    Get.put(PrescriptionController(useCase));
  }
}
