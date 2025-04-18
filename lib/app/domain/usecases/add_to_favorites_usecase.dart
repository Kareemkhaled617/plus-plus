import 'package:dartz/dartz.dart';
import '../entities/favorite_entity.dart';
import '../repositories/favorite_repository.dart';
import '../../core/errors/failure.dart';

class AddToFavoritesUseCase {
  final FavoriteRepository repository;

  AddToFavoritesUseCase(this.repository);

  Future<Either<Failure, FavouriteEntity?>> call(int productId) {
    return repository.addToFavorites(productId);
  }
}
