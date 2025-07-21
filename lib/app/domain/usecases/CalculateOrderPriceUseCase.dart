import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/OrderPriceEntity.dart';
import '../repositories/order_repository.dart';

class CalculateOrderPriceUseCase {
  final OrderRepository repository;

  CalculateOrderPriceUseCase(this.repository);

  Future<Either<Failure, OrderPriceEntity>> call(String userPoints, String lat, String lng) {
    return repository.calculatePrice(userPoints,lat,lng);
  }
}
