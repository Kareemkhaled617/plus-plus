import 'package:get/get.dart';

import '../../core/network/api_service.dart';
import '../../core/network/api_response.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl extends OrderRepository {
  final ApiService apiService;

  OrderRepositoryImpl(this.apiService);

  @override
  Future<List<OrderEntity>> getOrdersByStatus(String status) async {
    final ApiResponse response = await apiService.getRequest(
      'https://plusp.msarweb.net/api/orders/$status',
    );

    if (response.success) {
      final List orders = response.data['data']['orders'];
      return orders.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception(response.message ?? "Failed to fetch orders.");
    }
  }

  @override
  Future<OrderEntity> getOrderDetails(int orderId) async {
    final response = await apiService.getRequest('orders/$orderId/show');
    return OrderModel.fromJson(response.data['data']['order']);
  }

  @override
  Future<bool> cancelOrder(int orderId) async {
    final response = await apiService.postRequest('orders/cancel/$orderId', {});

    if (response.success && response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.message ?? "Failed to cancel order.".tr);
    }
  }
}
