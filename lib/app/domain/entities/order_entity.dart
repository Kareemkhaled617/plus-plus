import 'package:plus/app/domain/entities/product_entity.dart';

class OrderEntity {
  final int id;
  final String orderNumber;
  final String status;
  final String paymentMethod;
  final double totalPrice;
  final double orderChargePrice;
  final double discountPrice;
  final int userPoints;
  final int userPointsEarned;
  final double userPointsTotalDiscount;
  final UserAddressEntity userAddress;
  final List<OrderProductEntity> orderProducts;
  final String createdAt;
  final String estimatedDeliveryRange;
  final String estimatedDeliveryTime;
  final String riderTip;

  OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.paymentMethod,
    required this.totalPrice,
    required this.orderChargePrice,
    required this.discountPrice,
    required this.userPoints,
    required this.userPointsEarned,
    required this.userPointsTotalDiscount,
    required this.userAddress,
    required this.orderProducts,
    required this.createdAt,
    required this.riderTip,
    required this.estimatedDeliveryRange,
    required this.estimatedDeliveryTime,
  });
}

class UserAddressEntity {
  final int id;
  final String lat;
  final String lng;
  final String address;
  final String street;
  final String building;
  final String floor;
  final String department;
  final String setAs;

  UserAddressEntity({
    required this.id,
    required this.lat,
    required this.lng,
    required this.street,
    required this.address,
    required this.building,
    required this.floor,
    required this.department,
    required this.setAs,
  });
}

class OrderProductEntity {
  final int id;
  final ProductEntity product;
  final String? packageType;
  final int quantity;

  OrderProductEntity({
    required this.id,
    required this.product,
    this.packageType,
    required this.quantity,
  });
}
