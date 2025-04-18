import '../../domain/entities/business_settings_entity.dart';

class BusinessSettingsModel extends BusinessSettingsEntity {
  const BusinessSettingsModel({
    required super.businessName,
    required super.deliveryPrice,
    required super.pointsExchange,
    required super.priceExchange,
    required super.orderPriceExchange,
    required super.orderPointsExchange,
  });

  factory BusinessSettingsModel.fromJson(Map<String, dynamic> json) {
    return BusinessSettingsModel(
      businessName: json['business_name'],
      deliveryPrice: double.tryParse(json['delivery_price'].toString()) ?? 0.0,
      pointsExchange: double.tryParse(json['points_exchange'].toString()) ?? 0.0,
      priceExchange: double.tryParse(json['price_exchange'].toString()) ?? 0.0,
      orderPriceExchange:
      double.tryParse(json['order_price_exchange'].toString()) ?? 0.0,
      orderPointsExchange:
      double.tryParse(json['order_points_exchange'].toString()) ?? 0.0,
    );
  }
}
