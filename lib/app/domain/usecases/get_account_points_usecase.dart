// lib/domain/usecases/get_account_points_usecase.dart
import '../entities/point_entity.dart';
import '../repositories/account_repository.dart';

class GetAccountPointsUseCase {
  final AccountRepository repository;

  GetAccountPointsUseCase(this.repository);

  Future<PointDataEntity> call() async {
    return await repository.getAccountPoints();
  }
}
