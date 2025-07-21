import '../entities/cart_total_entity.dart';
import '../repositories/cart_repository.dart';
import '../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class GetCartTotalUseCase {
  final CartRepository repository;

  GetCartTotalUseCase(this.repository);

  Future<Either<Failure, CartTotalEntity>> call({
    required String lat,
    required String lng,
  }) {
    return repository.getCartTotal(lat: lat, lng: lng);
  }
}
