import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/cart_entity.dart';
import '../entities/cart_request_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<Either<Failure, List<CartRequestEntity>>> call() {
    return repository.getCart();
  }
}
