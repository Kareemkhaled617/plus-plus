import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../core/errors/failure.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final ApiService apiService;

  CartRepositoryImpl(this.apiService);

  @override
  @override
  Future<Either<Failure, CartEntity>> addToCart({
    required List<int> productIds,
    required List<int> quantityIds,
    required List<int?> packageTypeIds,
    String? couponCode,
  }) async {
    try {
      final payload = {
        "product_ids": productIds,
        "quantity_ids": quantityIds,
        "package_type_ids": packageTypeIds,
        "coupon_code": couponCode ?? "",
      };

      final response = await apiService.postRequest('/cart', payload);

      if (response.success) {
        final cartModel = CartModel.fromJson(response.data['data']);
        return Right(cartModel);
      } else {
        return Left(Failure(response.message ?? 'Failed to add to cart'));
      }
    } catch (e) {
      return Left(Failure('Unexpected error occurred'.tr));
    }
  }

  @override
  Future<Either<Failure, bool>> removeFromCart(int productId) async {
    try {
      final response =
          await apiService.deleteRequest('/cart/delete/$productId');

      if (response.success) {
        return const Right(true);
      } else {
        return Left(Failure(response.message ?? 'Failed to remove from cart'));
      }
    } catch (e) {
      return Left(Failure('Unexpected error occurred'.tr));
    }
  }
}
