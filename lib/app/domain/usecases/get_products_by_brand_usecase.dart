import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsByBrandUseCase {
  final ProductRepository repository;

  GetProductsByBrandUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call(int brandId) async {
    return await repository.getProductsByBrand(brandId);
  }

  Future<Either<Failure, List<ProductEntity>>> getProducts(int id) async {
    return await repository.getProductsByBrand(id);
  }
}
