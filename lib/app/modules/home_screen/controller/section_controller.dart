import 'package:get/get.dart';
import '../../../domain/usecases/get_sections_usecase.dart';
import '../../../domain/entities/section_entity.dart';
import '../../../core/errors/failure.dart';

class SectionController extends GetxController {
  final GetSectionsUseCase getSectionsUseCase;

  SectionController(this.getSectionsUseCase);

  var isLoading = false.obs;
  var sections = <SectionEntity>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchSections();
    super.onInit();
  }

  Future<void> fetchSections() async {
    isLoading.value = true;
    final result = await getSectionsUseCase();

    result.fold(
      (Failure failure) {
        errorMessage.value = failure.message;
        Get.snackbar("Error", failure.message);
      },
      (List<SectionEntity> data) {
        sections.assignAll(data);
      },
    );

    isLoading.value = false;
  }
}
