import '../../domain/entities/cart_total_entity.dart';

class CartTotalModel extends CartTotalEntity {
  CartTotalModel({
    required super.totalPrice,
    required super.totalDiscount,
    required super.couponDiscount,
    required super.chargePrice,
    required super.totalPriceAfterCharge,
  });

  factory CartTotalModel.fromJson(Map<String, dynamic> json) {
    return CartTotalModel(
      totalPrice: double.tryParse(json['total_price']?.toString() ?? '0') ?? 0.0,
      totalDiscount: double.tryParse(json['total_discount']?.toString() ?? '0') ?? 0.0,
      couponDiscount: double.tryParse(json['coupon_discount']?.toString() ?? '0') ?? 0.0,
      chargePrice: double.tryParse(json['charge_price']?.toString() ?? '0') ?? 0.0,
      totalPriceAfterCharge: double.tryParse(json['total_price_after_charge']?.toString() ?? '0') ?? 0.0,
    );
  }

}
