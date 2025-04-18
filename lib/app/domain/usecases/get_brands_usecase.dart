import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/brand_entity.dart';
import '../entities/product_entity.dart';
import '../repositories/brand_repository.dart';

class GetBrandsUseCase {
  final BrandRepository repository;

  GetBrandsUseCase({required this.repository});

  Future<Either<Failure, List<BrandEntity>>> call(String id) async {
    return await repository.getBrands(id);
  }

  Future<Either<Failure, List<ProductEntity>>> getProducts(String id) async {
    return await repository.getProducts(id);
  }
}
