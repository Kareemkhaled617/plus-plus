class PackageTypeEntity {
  final int id;
  final int unitQuantity;
  final String unitType;
  final double unitPrice;
  final int stock;

  PackageTypeEntity(
      {required this.id,
      required this.unitQuantity,
      required this.unitType,
      required this.unitPrice,
      required this.stock});
}
