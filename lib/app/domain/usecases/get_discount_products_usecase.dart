import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetDiscountProductsUseCase {
  final ProductRepository repository;

  GetDiscountProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() {
    return repository.getDiscountProducts();
  }
}
