import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/order_entity.dart';
import '../entities/order_request_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrdersByStatus(String status);

  Future<OrderEntity> getOrderDetails(int orderId);

  Future<bool> cancelOrder(int orderId); // New method
  Future<Either<Failure, OrderRequestEntity>> createOrder({
    required int userAddressId,
    required String paymentMethod,
    required int userPoints,
  });
}
