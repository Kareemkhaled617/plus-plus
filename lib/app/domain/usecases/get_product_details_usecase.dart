import 'package:dartz/dartz.dart';
import '../repositories/product_repository.dart';
import '../../core/errors/failure.dart';
import '../entities/product_entity.dart';

class GetProductDetailsUseCase {
  final ProductRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<Either<Failure, ProductEntity>> call(int productId) {
    return repository.getProductDetails(productId);
  }
}
