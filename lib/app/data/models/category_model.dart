import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.hasChild,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['category_id'],
      name: json['name'],
      imageUrl: json['image'],
      hasChild: json['has_child'] ?? false,
    );
  }

  static List<CategoryModel> fromJsonList(List<dynamic> list) {
    return list.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
