import 'package:dartz/dartz.dart';
import '../repositories/account_repository.dart';
import '../../core/errors/failure.dart';

class VerifyPhoneUseCase {
  final AccountRepository repository;

  VerifyPhoneUseCase(this.repository);

  Future<Either<Failure, String>> call(String code) {
    return repository.verifyPhone(code);
  }
}
