import '../../domain/entities/business_settings_entity.dart';

class BusinessSettingsModel extends BusinessSettingsEntity {
  const BusinessSettingsModel({
    required super.businessId,
    required super.businessName,
    required super.phoneNumber,
    required super.address,
    required super.deliveryPrice,
    required super.latitude,
    required super.longitude,
    required super.pointsExchange,
    required super.priceExchange,
    required super.orderPriceExchange,
    required super.orderPointsExchange,
    super.appVersion,
    super.androidVersion,
    super.iosVersion,
  });

  factory BusinessSettingsModel.fromJson(Map<String, dynamic> json) {

    return BusinessSettingsModel(
      businessId: json['business_id'] ?? 0,
      businessName: json['business_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      deliveryPrice:
          double.tryParse(json['delivery_price'].toString()) ?? 0.0,
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
      pointsExchange:
          double.tryParse(json['points_exchange'].toString()) ?? 0.0,
      priceExchange:
          double.tryParse(json['price_exchange'].toString()) ?? 0.0,
      orderPriceExchange:
          double.tryParse(json['order_price_exchange'].toString()) ?? 0.0,
      orderPointsExchange:
          double.tryParse(json['order_points_exchange'].toString()) ?? 0.0,
      appVersion: json['app_version'],
      androidVersion: json['android_version'],
      iosVersion: json['ios_version'],
    );
  }
}
