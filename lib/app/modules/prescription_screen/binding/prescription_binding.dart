import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/prescription_repository_impl.dart';
import '../../../domain/usecases/upload_prescription_usecase.dart';
import '../controller/prescription_controller.dart';


class PrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = ApiService();
    final repository = PrescriptionRepositoryImpl(apiService);
    final useCase = UploadPrescriptionUseCase(repository);
    Get.put(AddPrescriptionController(useCase));
  }
}
