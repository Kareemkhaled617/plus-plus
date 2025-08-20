class BannerEntity {
  final String image;
  final String url;
  final String position;
  final String urlType;
  final String? bannerUrlType;
  final String? actionType;
  final String? targetType;
  final String? targetValue;
  final String? targetName;

  BannerEntity({
    required this.image,
    required this.url,
    required this.position,
    required this.urlType,
    this.bannerUrlType,
    this.actionType,
    this.targetName,
    this.targetValue,
    this.targetType,
  });
}
