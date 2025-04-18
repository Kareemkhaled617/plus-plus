import '../../domain/entities/section_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/brand_entity.dart';
import 'product_model.dart';
import 'brand_model.dart';

class SectionModel extends SectionEntity {
  SectionModel({
    required super.id,
    required super.name,
    required super.firstColor,
    required super.secondColor,
    required super.titleColor,
    required super.sectionType,
    required super.products,
    required super.brands,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      name: json['name'],
      firstColor: json['first_color'],
      secondColor: json['second_color'],
      sectionType: json['section_type'],
      titleColor: json['title_color'],
      products: (json['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
      brands: (json['brands'] as List)
          .map((item) => BrandModel.fromJson(item))
          .toList(),
    );
  }
}
