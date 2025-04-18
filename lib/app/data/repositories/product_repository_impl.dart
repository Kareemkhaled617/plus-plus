import 'package:dartz/dartz.dart';
import '../../core/network/api_service.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService apiService;

  ProductRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int categoryId) async {
    final response =
        await apiService.getRequest('products/category/$categoryId');

    if (response.success) {
      final List productsJson = response.data['data']['products'];
      final products = ProductModel.fromJsonList(productsJson);
      return Right(products);
    } else {
      return Left(Failure(response.message ?? "Failed to load products",
          statusCode: response.statusCode));
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
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) async {
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
}
