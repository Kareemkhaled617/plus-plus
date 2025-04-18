class BusinessSettingsEntity {
  final String businessName;
  final double deliveryPrice;
  final double pointsExchange;
  final double priceExchange;
  final double orderPriceExchange;
  final double orderPointsExchange;

  const BusinessSettingsEntity({
    required this.businessName,
    required this.deliveryPrice,
    required this.pointsExchange,
    required this.priceExchange,
    required this.orderPriceExchange,
    required this.orderPointsExchange,
  });
}
