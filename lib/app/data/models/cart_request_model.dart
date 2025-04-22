import 'package:plus/app/data/models/product_model.dart';

import '../../domain/entities/cart_request_entity.dart';

class CartRequestModel extends CartRequestEntity {
  const CartRequestModel({
    required super.id,
    required super.quantity,
    required super.product,
    required super.packageType,
  });

  factory CartRequestModel.fromJson(Map<String, dynamic> json) {
    return CartRequestModel(
      id: json['id'],
      quantity: int.tryParse(json['quantity'].toString()) ?? 1,
      packageType: json['package_type'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}
