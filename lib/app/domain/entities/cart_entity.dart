import 'package:plus/app/domain/entities/product_entity.dart';

class CartEntity {
  final List<CartItemEntity> cartItems;
  final CartPriceDataEntity cartPriceData;

  CartEntity({
    required this.cartItems,
    required this.cartPriceData,
  });
}

class CartItemEntity {
  final int id;
  final int quantity;
  final PackageTypeEntity? packageType;
  final ProductEntity product;

  CartItemEntity({
    required this.id,
    required this.quantity,
    required this.packageType,
    required this.product,
  });
}

class PackageTypeEntity {
  final int id;
  final String unitType;
  final int unitQuantity;
  final double unitPrice;
  final int stock;

  PackageTypeEntity({
    required this.id,
    required this.unitType,
    required this.unitQuantity,
    required this.unitPrice,
    required this.stock,
  });
}

class CartPriceDataEntity {
  final double totalPrice;
  final double totalDiscount;
  final double totalPriceAfterCharge;
  final double couponDiscount;
  final double chargePrice;
  final String? coupon;
  final String? couponCode;

  CartPriceDataEntity({
    required this.totalPrice,
    required this.totalDiscount,
    required this.totalPriceAfterCharge,
    required this.couponDiscount,
    required this.chargePrice,
    this.coupon,
    this.couponCode,
  });
}
