import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/offer_entity.dart';

abstract class OfferRepository {
  Future<Either<Failure, List<OfferEntity>>> getOffers();
}
