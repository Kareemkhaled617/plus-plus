import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/brand_entity.dart';
import '../repositories/brand_repository.dart';

class GetBrandsByOfferUseCase {
  final BrandRepository repository;

  GetBrandsByOfferUseCase(this.repository);

  Future<Either<Failure, List<BrandEntity>>> call(int offerId) async {
    return await repository.getBrandsByOffer(offerId);
  }
}
