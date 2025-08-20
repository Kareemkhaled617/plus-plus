import '../../domain/entities/cart_request_entity.dart';
import '../../domain/entities/product_entity.dart';
import 'package_type_model.dart';

class ProductModel extends ProductEntity {
  final bool isSelected;

  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.benefits,
    required super.price,
    required super.stock,
    required super.imageUrl,
    required super.bodyImages,
    required super.brandId,
    required super.brandName,
    required super.brandImage,
    required super.categories,
    required super.packageTypes,
    required super.discountType,
    required super.discountValue,
    required super.perfectWith,
    required super.discountEndDate,
    required super.discountId,
    required super.offerType,
    required super.offerDiscountPercentage,
    required super.offerId,
    this.isSelected = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Unknown Product",
      description:
          json['description']?['description'] ?? "No description available",
      benefits:
          (json['description']?['benefits'] as String?)?.split(" - ") ?? [],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 1,
      imageUrl: json['image'] ?? "",
      bodyImages: (json['body-images'] as List<dynamic>?)
              ?.map((img) => img.toString())
              .toList() ??
          [],
      brandId: json['brand']?['id'] ?? 0,
      brandName: json['brand']?['name'] ?? "Unknown Brand",
      brandImage: json['brand']?['image'] ?? "",
      categories: (json['categories'] as List<dynamic>?)
              ?.map((cat) => CategoryModel.fromJson(cat))
              .toList() ??
          [],
      perfectWith: (json['perfect_with'] as List<dynamic>?)
              ?.map((product) => ProductModel.fromJson(product))
              .toList() ??
          [],
      packageTypes: (json['package_types'] as List<dynamic>?)
              ?.map((pkg) => PackageTypeModel.fromJson(pkg))
              .toList() ??
          [],
      discountType: json['discount_type'] ?? "",
      discountValue: json['discount'] != null
          ? (json['discount']['value'] as num?)?.toDouble() ?? 0.0
          : 0.0,
      discountEndDate:
          json['discount'] != null ? json['discount']['end_date'] : null,
      discountId:
          json['discount'] != null ? json['discount']['discount_id'] : 0,
      offerType: json['offer']?['offer_type'] ?? "",
      offerDiscountPercentage: json['offer']?['discount_percentage'] != null
          ? double.tryParse(json['offer']['discount_percentage'].toString()) ??
              0.0
          : 0.0,
      offerId: json['offer'] != null ? json['offer']['offer_id'] : 0,
      isSelected: json['is_selected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "benefits": benefits.join(" - "),
      "price": price,
      "stock": stock,
      "image": imageUrl,
      "body-images": bodyImages,
      "brand": {
        "id": brandId,
        "name": brandName,
        "image": brandImage,
      },
      "categories": categories
          .map((cat) => {
                "id": cat.id,
                "name": cat.name,
                "image": cat.image,
                "level": cat.level,
                "parent_id": cat.parentId,
              })
          .toList(),
      "package_types": packageTypes.map((pkg) => pkg.toJson()).toList(),
      "discount_type": discountType,
      "discount": {
        "discount_id": discountId,
        "value": discountValue,
        "end_date": discountEndDate,
      },
      "offer": {
        "offer_id": offerId,
        "offer_type": offerType,
        "discount_percentage": offerDiscountPercentage,
      },
      "is_selected": isSelected,
    };
  }

  /// ➕ copyWith لدعم التعديل على isSelected
  ProductModel copyWith({
    bool? isSelected,
  }) {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      benefits: benefits,
      perfectWith: perfectWith,
      price: price,
      stock: stock,
      imageUrl: imageUrl,
      bodyImages: bodyImages,
      brandId: brandId,
      brandName: brandName,
      brandImage: brandImage,
      categories: categories,
      packageTypes: packageTypes,
      discountType: discountType,
      discountValue: discountValue,
      discountEndDate: discountEndDate,
      discountId: discountId,
      offerType: offerType,
      offerDiscountPercentage: offerDiscountPercentage,
      offerId: offerId,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  static List<ProductEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  factory ProductModel.fromCartEntity(CartRequestEntity entity) {
    final product = entity.product;

    return ProductModel(
      id: product.id,
      name: product.name,
      perfectWith: product.perfectWith,
      description: product.description,
      benefits: product.benefits,
      price: product.price,
      stock: product.stock,
      imageUrl: product.imageUrl,
      bodyImages: product.bodyImages,
      brandId: product.brandId,
      brandName: product.brandName,
      brandImage: product.brandImage,
      categories: product.categories,
      packageTypes: product.packageTypes,
      discountType: product.discountType,
      discountValue: product.discountValue,
      discountEndDate: product.discountEndDate,
      discountId: product.discountId,
      offerId: product.offerId,
      offerType: product.offerType,
      offerDiscountPercentage: product.offerDiscountPercentage,
      isSelected: false, // يمكن تعديله حسب الحالة
    );
  }
}

class CategoryModel {
  final int id;
  final String name;
  final String image;
  final int level;
  final int? parentId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.level,
    required this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      level: json['level'],
      parentId: json['parent_id'],
    );
  }
}
