class OrderRequestModel {
  final int userAddressId;
  final String paymentMethod;
  final int userPoints;

  OrderRequestModel({
    required this.userAddressId,
    required this.paymentMethod,
    required this.userPoints,
  });

  Map<String, dynamic> toFormData() {
    return {
      'user_address_id': userAddressId.toString(),
      'payment_method': paymentMethod,
      'user_points': userPoints.toString(),
    };
  }
}
