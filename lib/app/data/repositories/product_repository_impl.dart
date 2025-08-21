import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../core/errors/failure.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/point_request_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService apiService;

  ProductRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProductsByCategory(
      int categoryId) async {
    final response =
    await apiService.getRequest('products/category/$categoryId');

    if (response.success) {
      try {
        final data = response.data['data'];

        // extract products
        final List productsJson = data['products'] ?? [];
        final products = ProductModel.fromJsonList(productsJson);

        // extract banner
        final String? categoryBanner = data['category_banner'];

        return Right({
          "products": products,
          "category_banner": categoryBanner,
        });
      } catch (e) {
        return Left(Failure("Parsing error: $e"));
      }
    } else {
      return Left(
        Failure(
          response.message ?? "Failed to load products",
          statusCode: response.statusCode,
        ),
      );
    }
  }


  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByBrand(
      int brandId) async {
    try {
      final response = await apiService.getRequest('/products/brand/$brandId');

      if (response.success) {
        final List productList = response.data['data']['products'];
        return Right(ProductModel.fromJsonList(productList));
      } else {
        return Left(Failure(response.message ?? "Failed to load products"));
      }
    } catch (e) {
      return Left(Failure("An error occurred while fetching products"));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsBySection(
      int sectionId) async {
    try {
      final response =
          await apiService.getRequest('/sections/content/$sectionId');

      if (response.success) {
        final List productList = response.data['data']['products'];
        return Right(ProductModel.fromJsonList(productList));
      } else {
        return Left(Failure(response.message ?? "Failed to load products"));
      }
    } catch (e) {
      return Left(Failure("An error occurred while fetching products"));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(
      int productId) async {
    try {
      final response = await apiService.getRequest('/products/$productId');

      if (response.success) {
        final productData = response.data['data']['product'];
        return Right(ProductModel.fromJson(productData));
      } else {
        return Left(Failure(
            response.data['message'] ?? "Failed to fetch product details"));
      }
    } catch (e) {
      return Left(Failure("An error occurred while fetching product details"));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByOfferAndBrand(
      int offerId, int brandId) async {
    try {
      final response =
          await apiService.getRequest('/offers/$offerId/brands/$brandId');

      if (response.success) {
        final List productList = response.data['data']['products'];
        return Right(ProductModel.fromJsonList(productList));
      } else {
        return Left(Failure(response.message ?? "Failed to load products"));
      }
    } catch (e) {
      print(e.toString());
      return Left(Failure("An error occurred while fetching products"));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
      String query) async {
    try {
      final response = await apiService.getRequest('/search?search=$query');

      if (response.success) {
        final List productList = response.data['data']['products'];
        return Right(ProductModel.fromJsonList(productList));
      } else {
        return Left(Failure(response.message ?? "Failed to search products"));
      }
    } catch (e) {
      return Left(Failure("An error occurred while searching"));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getDiscountProducts() async {
    try {
      final response = await apiService.getRequest('/discounts/products');
      if (response.success) {
        final List products = response.data['data']['products'];
        final result =
            products.map((item) => ProductModel.fromJson(item)).toList();
        return Right(result);
      } else {
        return Left(
            Failure(response.message ?? 'Failed to load discount products'.tr));
      }
    } catch (e) {
      return Left(Failure('Unexpected error occurred'.tr));
    }
  }

  @override
  Future<Either<Failure, void>> requestPoint(PointRequestEntity entity) async {
    try {
      final data = {'product_id': entity.productId.toString()};
      final response =
          await apiService.postRequest('/products/point-request', data);
      return response.success
          ? const Right(null)
          : Left(Failure(response.message ?? "Failed to request points"));
    } catch (e) {
      return Left(Failure("Unexpected error: $e"));
    }
  }
}
