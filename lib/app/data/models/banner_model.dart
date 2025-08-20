import '../../domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  BannerModel({
    required super.image,
    required super.url,
    required super.position,
    required super.urlType,
    super.bannerUrlType,
    super.actionType,
    super.targetName,
    super.targetType,
    super.targetValue,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'] ?? '',
      url: json['url'] ?? "",
      position: json['position'] ?? "",
      urlType: json['url_type'] ?? '',
      bannerUrlType: json['banner_url_type'] ?? '',
      actionType: json['action_type'] ?? '',
      targetType: json['target_type'] ?? "",
      targetValue: json['target_value'] ?? '',
      targetName: json['target_name'] ?? "",
    );
  }
}
