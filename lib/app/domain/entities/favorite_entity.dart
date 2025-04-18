class FavouriteEntity {
  final int id;
  final int productId;
  final String name;
  final Map description;
  final double price;
  final int stock;
  final String imageUrl;

  FavouriteEntity({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });
}
