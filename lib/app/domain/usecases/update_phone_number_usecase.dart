import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/update_phone_entity.dart';
import '../repositories/account_repository.dart';

class UpdatePhoneNumberUseCase {
  final AccountRepository repository;

  UpdatePhoneNumberUseCase(this.repository);

  Future<Either<Failure, UpdatePhoneEntity>> call(String phoneNumber) {
    return repository.updatePhoneNumber(phoneNumber);
  }
}
