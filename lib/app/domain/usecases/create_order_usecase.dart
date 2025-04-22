import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/order_entity.dart';
import '../entities/order_request_entity.dart';
import '../repositories/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, OrderRequestEntity>> call({
    required int userAddressId,
    required String paymentMethod,
    required int userPoints,
  }) {
    return repository.createOrder(
      userAddressId: userAddressId,
      paymentMethod: paymentMethod,
      userPoints: userPoints,
    );
  }
}
