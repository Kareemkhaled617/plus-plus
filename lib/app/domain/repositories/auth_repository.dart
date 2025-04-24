import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../../core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String phone);
  Future<Either<Failure, String>> verifyOtp(String phone, String otp,String fcm);
}
