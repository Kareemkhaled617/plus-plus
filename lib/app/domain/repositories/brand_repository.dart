import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/brand_entity.dart';
import '../entities/product_entity.dart';

abstract class BrandRepository {
  Future<Either<Failure, List<BrandEntity>>> getBrands(String id);
  Future<Either<Failure, List<ProductEntity>>> getProducts(String id);
  Future<Either<Failure, List<BrandEntity>>> getBrandsByOffer(int offerId);

}
