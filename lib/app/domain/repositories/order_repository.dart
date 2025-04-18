import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrdersByStatus(String status);
  Future<OrderEntity> getOrderDetails(int orderId);
  Future<bool> cancelOrder(int orderId); // New method

}
