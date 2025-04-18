import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/repositories/offer_repository.dart';

class GetOffersUseCase {
  final OfferRepository repository;

  GetOffersUseCase({required this.repository});

  Future<Either<Failure, List<OfferEntity>>> call() async {
    return await repository.getOffers();
  }
}
