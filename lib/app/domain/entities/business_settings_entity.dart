class BusinessSettingsEntity {
  final int businessId;
  final String businessName;
  final String phoneNumber;
  final String address;
  final double deliveryPrice;
  final double latitude;
  final double longitude;
  final double pointsExchange;
  final double priceExchange;
  final double orderPriceExchange;
  final double orderPointsExchange;
  final String? appVersion;
  final String? androidVersion;
  final String? iosVersion;

  const BusinessSettingsEntity({
    required this.businessId,
    required this.businessName,
    required this.phoneNumber,
    required this.address,
    required this.deliveryPrice,
    required this.latitude,
    required this.longitude,
    required this.pointsExchange,
    required this.priceExchange,
    required this.orderPriceExchange,
    required this.orderPointsExchange,
    this.appVersion,
    this.androidVersion,
    this.iosVersion,
  });
}
