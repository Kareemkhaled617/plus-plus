import 'package:dartz/dartz.dart';

import 'package:plus/app/core/errors/failure.dart';

import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<Either<Failure, bool>> call(int productId) {
    return repository.removeFromCart(productId);
  }
}
