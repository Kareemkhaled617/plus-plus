import 'package:get/get.dart';

import '../../core/network/api_service.dart';
import '../../domain/entities/business_settings_entity.dart';
import '../../domain/repositories/business_settings_repository.dart';
import '../models/business_settings_model.dart';

class BusinessSettingsRepositoryImpl implements BusinessSettingsRepository {
  final ApiService apiService;

  BusinessSettingsRepositoryImpl(this.apiService);

  @override
  Future<BusinessSettingsEntity> getBusinessSettings() async {
    final response = await apiService.getRequest('settings');

    if (response.success && response.statusCode == 200) {
      final data = response.data['data']['settings'];
      return BusinessSettingsModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch business settings'.tr);
    }
  }
}
