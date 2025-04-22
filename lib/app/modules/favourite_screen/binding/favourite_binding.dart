import 'package:get/get.dart';

import '../../../core/network/api_service.dart';
import '../../../data/repositories/favorite_repository_impl.dart';
import '../../../domain/repositories/favorite_repository.dart';
import '../../../domain/usecases/add_to_favorites_usecase.dart';
import '../../../domain/usecases/get_favourites_usecase.dart';
import '../controller/favorite_controller.dart';


class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<FavoriteRepository>(
            () => FavoriteRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<AddToFavoritesUseCase>(
            () => AddToFavoritesUseCase(Get.find<FavoriteRepository>()));
    Get.lazyPut<GetFavouritesUseCase>(
            () => GetFavouritesUseCase(Get.find<FavoriteRepository>()));

    Get.lazyPut<FavoriteController>(() =>
        FavoriteController(Get.find<AddToFavoritesUseCase>(), Get.find()));
  }
}
