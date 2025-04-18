import '../../domain/entities/prescription_entity.dart';

class PrescriptionModel extends PrescriptionEntity {
  PrescriptionModel({
    required super.id,
    required super.image,
    required super.aboutImage,
    required super.imageType,
    required super.status,
    required super.statusNumber,
    required super.orderProductNames,
    required super.createdAt,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json["id"],
      image: json["image"],
      aboutImage: json["about_image"],
      imageType: json["image_type"],
      status: json["status"],
      statusNumber: json["status_number"],
      orderProductNames: json["order_product_names"],
      createdAt: json["created_at"],
    );
  }
}
