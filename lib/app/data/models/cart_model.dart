import '../../domain/entities/cart_entity.dart';

import 'product_model.dart';

class CartModel extends CartEntity {
  CartModel({
    required List<CartItemModel> cartItems,
    required CartPriceDataModel cartPriceData,
  }) : super(cartItems: cartItems, cartPriceData: cartPriceData);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartItems: (json['cart'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      cartPriceData: CartPriceDataModel.fromJson(json['cart_price_data']),
    );
  }
}

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.id,
    required super.quantity,
    required super.packageType,
    required super.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      quantity: int.tryParse(json['quantity'].toString()) ?? 0,
      packageType: json['package_type'] != null
          ? PackageTypeEntity(
              id: json['package_type']['id'],
              unitType: json['package_type']['unit_type'],
              unitQuantity: json['package_type']['unit_quantity'],
              unitPrice: (json['package_type']['unit_price'] as num).toDouble(),
              stock: json['package_type']['stock'],
            )
          : null,
      product: ProductModel.fromJson(json['product']),
    );
  }
}

class CartPriceDataModel extends CartPriceDataEntity {
  CartPriceDataModel({
    required super.totalPrice,
    required super.totalDiscount,
    required super.totalPriceAfterCharge,
    required super.couponDiscount,
    required super.chargePrice,
    super.coupon,
    super.couponCode,
  });

  factory CartPriceDataModel.fromJson(Map<String, dynamic> json) {
    return CartPriceDataModel(
      totalPrice: (json['total_price'] as num).toDouble(),
      totalDiscount: (json['total_discount'] as num).toDouble(),
      totalPriceAfterCharge: (json['total_price_after_charge'] as num).toDouble(),
      couponDiscount: (json['coupon_discount'] as num).toDouble(),
      chargePrice: (json['charge_price'] as num).toDouble(),
      coupon: json['coupon'],
      couponCode: json['coupon_code'],
    );
  }
}
