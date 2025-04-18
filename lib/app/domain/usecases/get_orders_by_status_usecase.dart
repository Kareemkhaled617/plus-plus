import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrdersByStatusUseCase {
  final OrderRepository repository;

  GetOrdersByStatusUseCase(this.repository);

  Future<List<OrderEntity>> call(String status) async {
    return await repository.getOrdersByStatus(status);
  }
}
