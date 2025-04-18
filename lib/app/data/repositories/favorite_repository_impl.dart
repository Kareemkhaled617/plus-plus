import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/network/api_service.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/favorite_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../models/favorite_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final ApiService apiService;

  FavoriteRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, FavouriteEntity?>> addToFavorites(
      int productId) async {
    final formData = FormData.fromMap({'product_id': productId});

    final response = await apiService.postFormDataRequest(
      'favourites',
      formData,
    );

    if (response.success) {
      // ✅ Check if `favourite` exists in response
      if (response.data['data'].isNotEmpty) {
        final model =
            FavouriteModel.fromJson(response.data['data']['favourite']);
        return Right(model); // ✅ Return the parsed model
      } else {
        return Right(null); // ✅ Handle case when favorite is removed
      }
    } else {
      return Left(Failure(response.message ?? "Failed to add favorite",
          statusCode: response.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourites() async {
    final response = await apiService.getRequest("favourites");

    if (response.success) {
      final List favouritesJson = response.data['data']['favourites'];
      final favourites = favouritesJson
          .map((fav) => FavouriteEntity(
                id: fav['id'],
                productId: fav['product']['id'],
                name: fav['product']['name'],
                description: fav['product']['description'] ?? {},
                price: double.parse(fav['product']['price'].toString()),
                stock: fav['product']['stock'],
                imageUrl: fav['product']['image'],
              ))
          .toList();

      return Right(favourites);
    } else {
      return Left(Failure(response.message ?? "Failed to load favourites"));
    }
  }
}
