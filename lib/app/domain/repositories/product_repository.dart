import 'package:dartz/dartz.dart';
import '../entities/point_request_entity.dart';
import '../entities/product_entity.dart';
import '../../core/errors/failure.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(int categoryId);
  Future<Either<Failure, List<ProductEntity>>> getProductsByBrand(int brandId);
  Future<Either<Failure, List<ProductEntity>>> getProductsBySection(int sectionId);
  Future<Either<Failure, ProductEntity>> getProductDetails(int productId);
  Future<Either<Failure, List<ProductEntity>>> getProductsByOfferAndBrand(int offerId, int brandId);
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
  Future<Either<Failure, List<ProductEntity>>> getDiscountProducts();


  Future<Either<Failure, void>> requestPoint(PointRequestEntity entity);


}
