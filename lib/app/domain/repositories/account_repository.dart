import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/point_entity.dart';
import '../entities/update_phone_entity.dart';

abstract class AccountRepository {
  Future<bool> updateAccount(String name);
  Future<PointDataEntity> getAccountPoints();
  Future<bool> changeLanguage(String locale); // Add this
  Future<Either<Failure, UpdatePhoneEntity>> updatePhoneNumber(String phoneNumber);
  Future<Either<Failure, String>> verifyPhone(String code);


}
