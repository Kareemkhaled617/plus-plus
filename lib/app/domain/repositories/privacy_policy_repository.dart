import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/privacy_policy_entity.dart';

abstract class PrivacyPolicyRepository {
  Future<Either<Failure, List<PrivacyPolicyEntity>>> getPrivacyPolicy();
}
