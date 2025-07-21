class OrderPriceEntity {
  final double totalPrice;
  final double chargePrice;
  final double discountPrice;
  final String userPoints;
  final double userPointsExchangeRate;
  final double totalPriceAfterPoints;
  final double finalPrice;
  final double couponDiscount;

  OrderPriceEntity({
    required this.totalPrice,
    required this.chargePrice,
    required this.discountPrice,
    required this.userPoints,
    required this.userPointsExchangeRate,
    required this.totalPriceAfterPoints,
    required this.finalPrice,
    required this.couponDiscount,
  });
}
