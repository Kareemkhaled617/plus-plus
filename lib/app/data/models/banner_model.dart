import '../../domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel({
    required super.image,
    required super.url,
    required super.position,
    required super.urlType,
    super.bannerUrlType,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'],
      url: json['url'],
      position: json['position'],
      urlType: json['url_type'],
      bannerUrlType: json['banner_url_type'],
    );
  }
}
