import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/prescription_repository_impl.dart';
import '../../../domain/usecases/get_prescriptions_usecase.dart';
import '../controller/prescription_controller.dart';

class GetPrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<PrescriptionRepositoryImpl>(
        () => PrescriptionRepositoryImpl(Get.find<ApiService>()),
        fenix: true);
    Get.lazyPut<GetPrescriptionsUseCase>(
        () => GetPrescriptionsUseCase(Get.find<PrescriptionRepositoryImpl>()),
        fenix: true);
    Get.lazyPut<PrescriptionController>(
        () => PrescriptionController(Get.find<GetPrescriptionsUseCase>()),
        fenix: true);
  }
}
