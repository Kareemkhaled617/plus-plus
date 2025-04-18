import '../../domain/entities/favorite_entity.dart';

class FavouriteModel extends FavouriteEntity {
  FavouriteModel({
    required super.id,
    required super.productId,
    required super.name,
    required super.description,
    required super.price,
    required super.stock,
    required super.imageUrl,
  });

  /// **Factory Method for JSON Mapping**
  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      id: json['id'],
      productId: json['product']['id'],
      name: json['product']['name'],
      description: json['product']['description'],
      price: double.parse(json['product']['price'].toString()),
      stock: json['product']['stock'],
      imageUrl: json['product']['image'],
    );
  }

  /// **Convert List of JSON to List of Model Objects**
  static List<FavouriteModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FavouriteModel.fromJson(json)).toList();
  }
}
