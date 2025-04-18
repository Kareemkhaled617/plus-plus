import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failure.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/brand_repository.dart';
import '../models/brand_model.dart';
import '../models/product_model.dart';

class BrandRepositoryImpl implements BrandRepository {
  final ApiService apiService;

  BrandRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<BrandEntity>>> getBrands(String id) async {
    try {
      final response = await apiService.getRequest('/sections/content/$id');

      if (response.success) {
        final List brandList = response.data['data']['brands'];
        return Right(BrandModel.fromJsonList(brandList));
      } else {
        return Left(Failure(response.message ?? "Failed to load brands"));
      }
    } catch (e) {
      return Left(Failure("An error occurred while fetching brands"));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(String id) async {
    try {
      final response = await apiService.getRequest('/sections/content/$id');

      if (response.success) {
        final List productList = response.data['data']['products'];
        return Right(ProductModel.fromJsonList(productList));
      } else {
        return Left(Failure(response.message ?? "Failed to load product"));
      }
    } catch (e) {
      return Left(Failure("An error occurred while fetching product"));
    }
  }

  @override
  Future<Either<Failure, List<BrandEntity>>> getBrandsByOffer(
      int offerId) async {
    try {
      final response = await apiService.getRequest('/offers/$offerId/brands');

      if (response.success) {
        final List brandList = response.data['data']['brands'];
        return Right(BrandModel.fromJsonList(brandList));
      } else {
        return Left(Failure(response.message ?? "Failed to load brands"));
      }
    } catch (e) {
      return Left(Failure("An error occurred while fetching brands"));
    }
  }
}
