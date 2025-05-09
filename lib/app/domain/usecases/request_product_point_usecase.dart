import 'package:dartz/dartz.dart';
import '../entities/point_request_entity.dart';
import '../repositories/product_repository.dart';
import '../../core/errors/failure.dart';

class RequestProductPointUseCase {
  final ProductRepository repository;

  RequestProductPointUseCase(this.repository);

  Future<Either<Failure, void>> call(PointRequestEntity entity) {
    return repository.requestPoint(entity);
  }
}
