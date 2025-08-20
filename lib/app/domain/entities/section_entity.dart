import 'package:plus/app/domain/entities/banner_entity.dart';
import 'package:plus/app/domain/entities/product_entity.dart';

import 'brand_entity.dart';

class SectionEntity {
  final int id;
  final String name;
  final String firstColor;
  final String secondColor;
  final String backgroundColor;
  final String titleColor;
  final String sectionType;
  final String titlePosition;
  final String image;
  final List<ProductEntity> products;
  final List<BannerEntity> aboveBanners;
  final List<BannerEntity> belowBanners;
  final List<BrandEntity> brands;

  SectionEntity({
    required this.id,
    required this.name,
    required this.firstColor,
    required this.secondColor,
    required this.titleColor,
    required this.sectionType,
    required this.products,
    required this.brands,
    required this.backgroundColor,
    required this.titlePosition,
    required this.aboveBanners,
    required this.belowBanners,
    required this.image,
  });
}
