import '../../domain/entities/OrderPriceEntity.dart';

class OrderPriceModel extends OrderPriceEntity {
  OrderPriceModel({
    required super.totalPrice,
    required super.chargePrice,
    required super.discountPrice,
    required super.userPoints,
    required super.userPointsExchangeRate,
    required super.totalPriceAfterPoints,
    required super.finalPrice,
    required super.couponDiscount,
    required super.riderTip,
  });

  factory OrderPriceModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return OrderPriceModel(
      totalPrice: (data['total_price'] ?? 0).toDouble(),
      couponDiscount: (data['coupon_discount'] ?? 0).toDouble(),
      chargePrice: (data['charge_price'] ?? 0).toDouble(),
      discountPrice: (data['discount_price'] ?? 0).toDouble(),
      userPoints: data['user_points'].toString(),
      userPointsExchangeRate:
          (data['user_points_exchange_rate'] ?? 0).toDouble(),
      totalPriceAfterPoints: (data['total_price_after_points'] ?? 0).toDouble(),
      finalPrice: (data['final_price'] ?? 0).toDouble(),
      riderTip: (data['rider_tip'] ?? 0).toDouble(),
    );
  }
}
