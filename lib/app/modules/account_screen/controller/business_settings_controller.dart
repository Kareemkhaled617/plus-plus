import 'package:get/get.dart';
import '../../../domain/entities/business_settings_entity.dart';
import '../../../domain/usecases/get_business_settings_usecase.dart';

class BusinessSettingsController extends GetxController {
  final GetBusinessSettingsUseCase getBusinessSettingsUseCase;

  BusinessSettingsController(this.getBusinessSettingsUseCase);

  var settings = Rxn<BusinessSettingsEntity>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBusinessSettings();
  }

  Future<void> fetchBusinessSettings() async {
    isLoading.value = true;
    settings.value = await getBusinessSettingsUseCase();
    isLoading.value = false;
  }
}
