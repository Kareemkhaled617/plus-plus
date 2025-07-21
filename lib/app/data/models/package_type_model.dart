import 'package:plus/app/domain/entities/package_type_entity.dart';

class PackageTypeModel extends PackageTypeEntity {
  PackageTypeModel({
    required super.id,
    required super.unitQuantity,
    required super.unitType,
    required super.unitPrice,
    required super.stock,
  });

  factory PackageTypeModel.fromJson(Map<String, dynamic> json) {
    return PackageTypeModel(
      id: json['id'],
      unitQuantity: (json['unit_quantity'] as num?)?.toInt() ?? 0,
      unitType: json['unit_type'],
      unitPrice: (json['unit_price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock']??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "unit_quantity": unitQuantity,
      "unit_type": unitType,
      "unit_price": unitPrice,
      "stock": stock,
    };
  }
}
