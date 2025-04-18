import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/offer_entity.dart';
import '../../domain/repositories/offer_repository.dart';
import '../models/offer_model.dart';
import '../../core/network/api_service.dart';

class OfferRepositoryImpl implements OfferRepository {
  final ApiService apiService;

  OfferRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers() async {
    try {
      final response = await apiService.getRequest('offers');

      if (response.success) {
        final List offersJson = response.data['data']['offers'];
        final offers = offersJson
            .map((json) => OfferModel.fromJson(json))
            .toList();

        return Right(offers);
      } else {
        return Left(Failure(response.message ?? "Failed to fetch offers"));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
