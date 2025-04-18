import 'package:get/get.dart';
import '../../../domain/entities/prescription_entity.dart';
import '../../../domain/usecases/get_prescriptions_usecase.dart';

class PrescriptionController extends GetxController {
  final GetPrescriptionsUseCase getPrescriptionsUseCase;

  var prescriptions = <PrescriptionEntity>[].obs;
  var isLoading = true.obs;

  PrescriptionController(this.getPrescriptionsUseCase);

  @override
  void onInit() {
    super.onInit();
    fetchPrescriptions();
  }

  Future<void> fetchPrescriptions() async {
    isLoading.value = true;

    final result = await getPrescriptionsUseCase();

    result.fold(
          (failure) {
        Get.snackbar("Error", failure.message);
      },
          (data) {
        prescriptions.value = data;
      },
    );

    isLoading.value = false;
  }
}
