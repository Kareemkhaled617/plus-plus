import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsByOfferAndBrandUseCase {
  final ProductRepository repository;

  GetProductsByOfferAndBrandUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(int offerId, int brandId) async {
    return await repository.getProductsByOfferAndBrand(offerId, brandId);
  }
}
