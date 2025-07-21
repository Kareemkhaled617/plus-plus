import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../core/errors/failure.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_request_entity.dart';
import '../../domain/entities/cart_total_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_model.dart';
import '../models/cart_request_model.dart';
import '../models/cart_total_model.dart';

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
  @override
  Future<Either<Failure, List<CartRequestEntity>>> getCart() async {
    try {
      final response = await apiService.getRequest('/cart');
      if (response.success) {
        final List data = response.data['data'];
        final List<CartRequestEntity> cartItems = data
            .map((item) => CartRequestModel.fromJson(item))
            .toList();
        return Right(cartItems);
      } else {
        return Left(Failure(response.message ?? 'Failed to fetch cart'.tr));
      }
    } catch (e) {
      return Left(Failure('Unexpected error occurred'.tr));
    }
  }

  @override
  Future<Either<Failure, CartTotalEntity>> getCartTotal({
    required String lat,
    required String lng,
  }) async {
    try {
      final response = await apiService.postRequest(
        'cart/get-total-amount',
        {'lat': lat, 'lng': lng},
      );
      print('response.data: ${response.data}');
      print(response.data);
      final model = CartTotalModel.fromJson(response.data['data']);
      return Right(model);
    } catch (e) {
      print(e.toString());
      return Left(Failure('Unexpected error occurred'.tr));
    }
  }
}
