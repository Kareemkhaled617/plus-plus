import 'package:dio/dio.dart';

import '../../core/network/api_service.dart';
import '../../domain/entities/point_entity.dart';
import '../../domain/repositories/account_repository.dart';
import '../models/point_model.dart';

class AccountRepositoryImpl extends AccountRepository {
  final ApiService apiService;

  AccountRepositoryImpl(this.apiService);

  @override
  Future<bool> updateAccount(String name) async {
    final response = await apiService.patchRequest(
      '/account/update',
      {"name": name},
    );
    return response.success && response.statusCode == 200;
  }

  @override
  Future<PointDataEntity> getAccountPoints() async {
    final response = await apiService.getRequest('account/points');
    return PointDataModel.fromJson(response.data['data']);
  }

  Future<bool> changeLanguage(String locale) async {
    final response = await apiService.postFormDataRequest(
      'account/change-language',
      FormData.fromMap({'locale': locale}),
    );
    return response.success && response.statusCode == 200;
  }
}
