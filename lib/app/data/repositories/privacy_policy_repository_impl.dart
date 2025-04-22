
import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/privacy_policy_entity.dart';
import '../../domain/repositories/privacy_policy_repository.dart';
import '../models/privacy_policy_model.dart';

class PrivacyPolicyRepositoryImpl implements PrivacyPolicyRepository {
  final ApiService apiService;

  PrivacyPolicyRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<PrivacyPolicyEntity>>> getPrivacyPolicy() async {
    try {
      final response = await apiService.getRequest('/settings/privacy-policy');

      if (response.success) {
        final List dataList = response.data['data'];
        final policies = dataList
            .map((item) => PrivacyPolicyModel.fromJson(item))
            .toList();
        return Right(policies);
      } else {
        return Left(Failure(response.message ?? 'Failed to load policy'));
      }
    } catch (e) {
      return Left(Failure('Unexpected error occurred'));
    }
  }
}
