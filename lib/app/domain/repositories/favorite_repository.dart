import 'package:dartz/dartz.dart';
import '../entities/favorite_entity.dart';
import '../../core/errors/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, FavouriteEntity?>> addToFavorites(int productId);
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites();
}
