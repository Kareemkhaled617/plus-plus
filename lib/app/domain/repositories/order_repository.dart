import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/OrderPriceEntity.dart';
import '../entities/address_entity.dart';
import '../entities/order_entity.dart';
import '../entities/order_request_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrdersByStatus(String status);

  Future<OrderEntity> getOrderDetails(int orderId);

  Future<bool> cancelOrder(int orderId); // New method
  Future<Either<Failure, OrderPriceEntity>> calculatePrice(
      String userPoints, String lat, String lng);
  Future<Either<Failure, OrderRequestEntity>> createOrder({
    required AddressEntity userAddress,
    required String paymentMethod,
    required int userPoints,
  });
}
