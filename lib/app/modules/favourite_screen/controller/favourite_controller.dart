import 'package:get/get.dart';
import '../../../domain/entities/favorite_entity.dart';
import '../../../domain/usecases/get_favourites_usecase.dart';

import '../../../core/errors/failure.dart';

class FavouriteController extends GetxController {
  final GetFavouritesUseCase getFavouritesUseCase;

  FavouriteController(this.getFavouritesUseCase);

  var isLoading = false.obs;
  var favourites = <FavouriteEntity>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchFavourites();
    super.onInit();
  }

  void fetchFavourites() async {
    isLoading.value = true;
    final result = await getFavouritesUseCase();

    result.fold(
      (Failure failure) => errorMessage.value = failure.message,
      (List<FavouriteEntity> data) => favourites.assignAll(data),
    );

    isLoading.value = false;
  }
}
