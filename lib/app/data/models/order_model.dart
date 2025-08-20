import 'package:plus/app/domain/entities/order_entity.dart';
import 'package:plus/app/data/models/product_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.orderNumber,
    required super.status,
    required super.paymentMethod,
    required super.totalPrice,
    required super.orderChargePrice,
    required super.discountPrice,
    required super.userPoints,
    required super.userPointsTotalDiscount,
    required super.userAddress,
    required super.orderProducts,
    required super.createdAt,
    required super.userPointsEarned,
    required super.riderTip,
    required super.estimatedDeliveryRange,
    required super.estimatedDeliveryTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderNumber: json['order_number'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      orderChargePrice:
          double.tryParse(json['order_charge_price'].toString()) ?? 0.0,
      discountPrice: double.tryParse(json['discount_price'].toString()) ?? 0.0,
      userPoints: int.tryParse(json['user_points'].toString()) ?? 0,
      userPointsEarned:
          int.tryParse(json['user_points_earned'].toString()) ?? 0,
      userPointsTotalDiscount:
          double.tryParse(json['user_points_total_discount'].toString()) ?? 0.0,
      userAddress: UserAddressModel.fromJson(json['user_address']),
      orderProducts: (json['order_products'] as List)
          .map((e) => OrderProductModel.fromJson(e))
          .toList(),
      createdAt: json['created_at'],
      riderTip: json['rider_tip'],
      estimatedDeliveryTime: json['estimated_delivery_time'],
      estimatedDeliveryRange: json['estimated_delivery_range'],
    );
  }
}

class UserAddressModel extends UserAddressEntity {
  UserAddressModel({
    required super.id,
    required super.lat,
    required super.lng,
    required super.street,
    required super.address,
    required super.building,
    required super.floor,
    required super.department,
    required super.setAs,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) {
    return UserAddressModel(
      id: json['id'],
      lat: json['lat'],
      lng: json['lng'],
      address: json['address'],
      street: json['street'],
      building: json['building'],
      floor: json['floor'],
      department: json['department'],
      setAs: json['set_as'],
    );
  }
}

class OrderProductModel extends OrderProductEntity {
  OrderProductModel({
    required super.id,
    required super.product,
    required super.packageType,
    required super.quantity,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      packageType: json['package_type'],
      quantity: int.tryParse(json['quantity'].toString()) ?? 1,
    );
  }
}
