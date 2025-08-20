import '../../domain/entities/section_entity.dart';
import 'banner_model.dart';
import 'brand_model.dart';
import 'product_model.dart';

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
    required super.backgroundColor,
    required super.titlePosition,
    required super.aboveBanners,
    required super.belowBanners,
    required super.image,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      name: json['name'] ?? '',
      firstColor: json['first_color'] ?? '',
      secondColor: json['second_color'] ?? "",
      backgroundColor: json['background_image'] ?? "",
      titlePosition: json['title_position'] ?? '',
      image: json['image'] ?? '',
      sectionType: json['section_type'] ?? '',
      titleColor: json['title_color'] ?? "",
      products: (json['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
      brands: (json['brands'] as List)
          .map((item) => BrandModel.fromJson(item))
          .toList(),
      aboveBanners: (json['above_banners'] as List)
          .map((item) => BannerModel.fromJson(item))
          .toList(),
      belowBanners: (json['below_banners'] as List)
          .map((item) => BannerModel.fromJson(item))
          .toList(),
    );
  }
}
