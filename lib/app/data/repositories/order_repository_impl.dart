import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../core/errors/failure.dart';
import '../../core/network/api_response.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/OrderPriceEntity.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_request_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../models/OrderPriceModel.dart';
import '../models/order_model.dart';
import '../models/order_request_model.dart';

class OrderRepositoryImpl extends OrderRepository {
  final ApiService apiService;

  OrderRepositoryImpl(this.apiService);
  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      final res = await apiService.getRequest('/orders');
      if (!res.success) {
        return Left(Failure(res.message ?? 'Failed to fetch orders'));
      }

      // API returns data.order (not data.orders)
      final List list = (res.data['data']['order'] as List? ?? []);
      final items = list.map((e) => OrderModel.fromJson(e)).toList();
      return Right(items);
    } catch (_) {
      return Left(Failure('Unexpected error occurred'));
    }
  }
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

  @override
  Future<Either<Failure, OrderPriceEntity>> calculatePrice(
      String userPoints, String lat, String lng) async {
    ApiResponse response;
    try {
      response = await apiService.postRequest(
        'orders/calculate-price',
        {
          'user_points': userPoints,
          'lat': lat,
          'lng': lng,
        },
      );
      return Right(OrderPriceModel.fromJson(response.data));
    } catch (e) {
      return Left(Failure('The user points not valid'));
    }
  }

  @override
  Future<Either<Failure, OrderRequestEntity>> createOrder({
    required AddressEntity userAddress,
    required String paymentMethod,
    required String couponCode,
    required String riderTip,
    required int userPoints,
  }) async {
    try {
      final model = OrderRequestModel(
        userAddress: userAddress,
        paymentMethod: paymentMethod,
        couponCode: couponCode,
        riderTip: riderTip,
        userPoints: userPoints,
      );

      final response =
          await apiService.postRequest('/orders', model.toFormData());

      if (response.success) {
        return Right(OrderRequestEntity(
            isSuccess: true,
            message: response.message ?? 'Order created successfully'.tr));
      } else {
        return Left(Failure(response.message ?? 'Failed to create order'.tr));
      }
    } catch (e) {
      return Left(Failure('Unexpected error occurred'.tr));
    }
  }
}
