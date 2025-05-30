import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failure.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/point_entity.dart';
import '../../domain/entities/update_phone_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/account_repository.dart';
import '../models/point_model.dart';
import '../models/update_phone_model.dart';
import '../models/user_profile_model.dart';

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

  @override
  Future<bool> changeLanguage(String locale) async {
    final response = await apiService.postFormDataRequest(
      'account/change-language',
      FormData.fromMap({'locale': locale}),
    );
    return response.success && response.statusCode == 200;
  }

  @override
  Future<Either<Failure, UpdatePhoneEntity>> updatePhoneNumber(
      String phoneNumber) async {
    try {
      final response = await apiService.postRequest(
        '/account/update-phone',
        {'temporal_phone_number': phoneNumber},
      );

      if (response.success) {
        final model = UpdatePhoneModel.fromJson(response.data);
        return Right(model);
      } else {
        return Left(
            Failure(response.message ?? "Failed to update phone number"));
      }
    } catch (e) {
      return Left(Failure("Unexpected error occurred"));
    }
  }

  @override
  Future<Either<Failure, String>> verifyPhone(String code) async {
    try {
      final response =
          await apiService.postRequest('/account/verify-phone', {'code': code});

      if (response.success) {
        return Right(response.message ?? "Updated successfully!");
      } else {
        return Left(Failure(response.message ?? "Verification failed"));
      }
    } catch (e) {
      return Left(Failure("Unexpected error occurred"));
    }
  }
  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    try {
      final response = await apiService.getRequest('/account/profile');
      if (response.success) {
        return Right(UserProfileModel.fromJson(response.data['data']));
      } else {
        return Left(Failure(response.message ?? 'Failed to fetch profile'));
      }
    } catch (e) {
      return Left(Failure("Unexpected error occurred"));
    }
  }
}
