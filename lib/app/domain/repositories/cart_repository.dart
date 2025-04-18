import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> addToCart({
    required List<int> productIds,
    required List<int> quantityIds,
    required List<int?> packageTypeIds,
    String? couponCode,
  });
  Future<Either<Failure, bool>> removeFromCart(int productId);
}
