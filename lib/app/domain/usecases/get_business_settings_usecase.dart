import '../entities/business_settings_entity.dart';
import '../repositories/business_settings_repository.dart';

class GetBusinessSettingsUseCase {
  final BusinessSettingsRepository repository;

  GetBusinessSettingsUseCase(this.repository);

  Future<BusinessSettingsEntity> call() {
    return repository.getBusinessSettings();
  }
}
