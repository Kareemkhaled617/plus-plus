import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/favorite_entity.dart';
import '../repositories/favorite_repository.dart';

class GetFavouritesUseCase {
  final FavoriteRepository repository;

  GetFavouritesUseCase(this.repository);

  Future<Either<Failure, List<FavouriteEntity>>> call() async {
    return await repository.getFavourites();
  }
}
