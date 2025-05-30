import '../../core/errors/failure.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/account_repository.dart';

import 'package:dartz/dartz.dart';

class GetUserProfileUseCase {
  final AccountRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<Either<Failure, UserProfileEntity>> call() {
    return repository.getUserProfile();
  }
}
