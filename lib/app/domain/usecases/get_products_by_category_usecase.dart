import 'package:dartz/dartz.dart';
import '../repositories/product_repository.dart';
import '../entities/product_entity.dart';
import '../../core/errors/failure.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(int categoryId) {
    return repository.getProductsByCategory(categoryId);
  }
}
