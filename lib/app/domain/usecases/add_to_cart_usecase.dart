import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<Either<Failure, CartEntity>> call({
    required List<int> productIds,
    required List<int> quantityIds,
    required List<int?> packageTypeIds,
    String? couponCode,
  }) {
    return repository.addToCart(
      productIds: productIds,
      quantityIds: quantityIds,
      packageTypeIds: packageTypeIds,
      couponCode: couponCode,
    );
  }
}
