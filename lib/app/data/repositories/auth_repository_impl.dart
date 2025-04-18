import '../../core/network/api_service.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/login_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, UserEntity>> login(String phone) async {
    try {
      final response =
          await apiService.postRequest('auth/signin', {'phone': phone});
      final data = response.data;

      if (response.success) {
        return Right(UserModel.fromJson(data));
      } else {
        return Left(Failure(data['message'] ?? 'Login failed'));
      }
    } catch (e) {
      print('---------------------------------------');
      print(e.toString());
      return Left(Failure('Network error'));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp(String phone, String otp) async {
    final response = await apiService.postRequest(
      'auth/verify-otp',
      {'phone': phone, 'code': otp},
    );

    if (response.success) {
      final token = response.data["token"];
      return Right(token);
    } else {
      return Left(Failure(response.message ?? "Failed to verify OTP"));
    }
  }
}
