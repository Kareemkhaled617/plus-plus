class CartTotalEntity {
  final double totalPrice;
  final double totalDiscount;
  final double couponDiscount;
  final double chargePrice;
  final double totalPriceAfterCharge;

  CartTotalEntity({
    required this.totalPrice,
    required this.totalDiscount,
    required this.couponDiscount,
    required this.chargePrice,
    required this.totalPriceAfterCharge,
  });
}
