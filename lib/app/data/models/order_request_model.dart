import '../../domain/entities/address_entity.dart';

class OrderRequestModel {
  final AddressEntity userAddress;
  final String paymentMethod;
  final String couponCode;
  final String riderTip;
  final int userPoints;

  OrderRequestModel({
    required this.userAddress,
    required this.paymentMethod,
    required this.userPoints,
    required this.riderTip,
    required this.couponCode,
  });

  Map<String, dynamic> toFormData() {
    return {
      'user_address_id': userAddress.id.toString(),
      'address_type': userAddress.setAs == 'current' ? 'current ' : 'exist',
      'lat': userAddress.lat,
      'lng': userAddress.lng.toString(),
      'address': userAddress.address.toString(),
      'payment_method': paymentMethod,
      'user_points': userPoints.toString(),
      'coupon_code': couponCode.toString(),
      'rider_tip': riderTip.toString(),
    };
  }
}
