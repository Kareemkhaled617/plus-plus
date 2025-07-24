import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../repositories/cart_repository.dart';

class RemoveAllFromCartUseCase {
  final CartRepository repository;

  RemoveAllFromCartUseCase(this.repository);

  Future<Either<Failure, bool>> call() {
    return repository.removeAllFromCart();
  }
}
