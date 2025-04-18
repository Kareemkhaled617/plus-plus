import 'package:get/get.dart';

import '../controller/favorite_controller.dart';
import '../core/network/api_service.dart';
import '../data/repositories/favorite_repository_impl.dart';
import '../domain/repositories/favorite_repository.dart';
import '../domain/usecases/add_to_favorites_usecase.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<FavoriteRepository>(
        () => FavoriteRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<AddToFavoritesUseCase>(
        () => AddToFavoritesUseCase(Get.find<FavoriteRepository>()));

    Get.lazyPut<FavoriteController>(
        () => FavoriteController(Get.find<AddToFavoritesUseCase>()));
  }
}
