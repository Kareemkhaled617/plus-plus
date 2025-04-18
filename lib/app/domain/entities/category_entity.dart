class CategoryEntity {
  final int id;
  final String name;
  final String imageUrl;
  final bool hasChild;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.hasChild,
  });
}
