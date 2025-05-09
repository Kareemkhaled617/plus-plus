import '../../domain/entities/point_request_entity.dart';

class PointRequestModel extends PointRequestEntity {
  const PointRequestModel({required super.productId});

  Map<String, dynamic> toJson() => {'product_id': productId};
}
