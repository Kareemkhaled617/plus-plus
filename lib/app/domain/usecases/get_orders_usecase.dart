// lib/app/domain/usecases/get_orders_usecase.dart
import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class GetOrdersUseCase {
  final OrderRepository repo;
  GetOrdersUseCase(this.repo);

  Future<Either<Failure, List<OrderEntity>>> call() => repo.getOrders();
}
