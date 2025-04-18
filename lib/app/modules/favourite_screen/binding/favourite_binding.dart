import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/favorite_repository_impl.dart';
import '../../../domain/usecases/get_favourites_usecase.dart';
import '../controller/favourite_controller.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = ApiService();
    final repository = FavoriteRepositoryImpl(apiService);
    final useCase = GetFavouritesUseCase(repository);
    Get.put(FavouriteController(useCase));
  }
}
