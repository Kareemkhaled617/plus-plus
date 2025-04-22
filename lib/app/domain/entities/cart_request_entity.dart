import 'product_entity.dart';

class CartRequestEntity {
  final int id;
  final int quantity;
  final dynamic packageType;
  final ProductEntity product;

  const CartRequestEntity({
    required this.id,
    required this.quantity,
    required this.packageType,
    required this.product,
  });
}
