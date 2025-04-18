class BannerEntity {
  final String image;
  final String url;
  final String position;
  final String urlType;
  final String? bannerUrlType;

  BannerEntity({
    required this.image,
    required this.url,
    required this.position,
    required this.urlType,
    this.bannerUrlType,
  });
}
