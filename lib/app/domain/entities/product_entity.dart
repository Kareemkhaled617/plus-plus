import '../../data/models/package_type_model.dart';
import '../../data/models/product_model.dart';

class ProductEntity {
  final int id;
  final String name;
  final String description;
  final List benefits;
  final double price;
  final int stock;
  final String imageUrl;
  final List<String> bodyImages;
  final int brandId;
  final String brandName;
  final String brandImage;
  final List<CategoryModel> categories;
  final List<PackageTypeModel> packageTypes;
  final String discountType;
  final double discountValue;
  final String? discountEndDate;
  final int? discountId;
  final String? offerType;
  final double? offerDiscountPercentage;
  final int? offerId;

  /// ✅ New property to track selection
  final bool isSelected;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.benefits,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.bodyImages,
    required this.brandId,
    required this.brandName,
    required this.brandImage,
    required this.categories,
    required this.packageTypes,
    required this.discountType,
    required this.discountValue,
    required this.discountEndDate,
    required this.discountId,
    required this.offerType,
    required this.offerDiscountPercentage,
    required this.offerId,
    this.isSelected = false, // ✅ default value false
  });
}
