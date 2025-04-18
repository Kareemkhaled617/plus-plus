import '../../domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  BrandModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'] ?? "",
    );
  }

  static List<BrandModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BrandModel.fromJson(json)).toList();
  }
}
