import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrderDetailsUseCase {
  final OrderRepository repository;

  GetOrderDetailsUseCase(this.repository);

  Future<OrderEntity> call(int orderId) async {
    return await repository.getOrderDetails(orderId);
  }
}
