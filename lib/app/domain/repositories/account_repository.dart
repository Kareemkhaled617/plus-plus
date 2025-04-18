import '../entities/point_entity.dart';

abstract class AccountRepository {
  Future<bool> updateAccount(String name);
  Future<PointDataEntity> getAccountPoints();
  Future<bool> changeLanguage(String locale); // Add this
}
