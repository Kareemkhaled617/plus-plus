import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/address_entity.dart';
import '../entities/order_entity.dart';
import '../entities/order_request_entity.dart';
import '../repositories/order_repository.dart';

class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, OrderRequestEntity>> call({
    required AddressEntity userAddress,
    required String paymentMethod,
    required String couponCode,
    required String riderTip,
    required int userPoints,
  }) {
    return repository.createOrder(
      userAddress: userAddress,
      paymentMethod: paymentMethod,
      riderTip: riderTip,
      couponCode: couponCode,
      userPoints: userPoints,
    );
  }
}
