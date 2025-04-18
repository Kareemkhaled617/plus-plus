import '../entities/business_settings_entity.dart';

abstract class BusinessSettingsRepository {
  Future<BusinessSettingsEntity> getBusinessSettings();
}
