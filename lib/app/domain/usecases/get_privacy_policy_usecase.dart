import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/privacy_policy_entity.dart';
import '../repositories/privacy_policy_repository.dart';

class GetPrivacyPolicyUseCase {
  final PrivacyPolicyRepository repository;

  GetPrivacyPolicyUseCase(this.repository);

  Future<Either<Failure, List<PrivacyPolicyEntity>>> call() {
    return repository.getPrivacyPolicy();
  }
}
