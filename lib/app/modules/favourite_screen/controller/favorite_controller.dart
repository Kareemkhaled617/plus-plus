import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/favorite_entity.dart';
import '../../../domain/usecases/add_to_favorites_usecase.dart';
import '../../../domain/usecases/get_favourites_usecase.dart';

class FavoriteController extends GetxController {
  final AddToFavoritesUseCase addToFavoritesUseCase;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final GetFavouritesUseCase getFavouritesUseCase;

  FavoriteController(this.addToFavoritesUseCase, this.getFavouritesUseCase);

  var isLoading = false.obs;
  var favoriteProduct = Rxn<FavouriteEntity>();
  var errorMessage = ''.obs;
  var cachedFavorites = <int>[].obs;
  var isLoadingApi = false.obs;
  var favourites = <FavouriteEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCachedFavorites();
  }

  void fetchFavourites() async {
    isLoading.value = true;
    final result = await getFavouritesUseCase();

    result.fold(
          (Failure failure) => errorMessage.value = failure.message,
          (List<FavouriteEntity> data) {
        favourites.assignAll(data);

        // ✅ تحديث cachedFavorites من قائمة الـ favorites
        cachedFavorites.assignAll(data.map((e) => e.productId).toList());

        // ✅ حفظ القائمة في التخزين الآمن
        saveCachedFavorites();
      },
    );

    isLoading.value = false;
  }


  /// **Add product to favorites (API + Cache)**
  Future<void> addProductToFavorites(int productId) async {
    isLoading.value = true;
    toggleFavorite(productId); // ✅ Cache favorite product
    final result = await addToFavoritesUseCase(productId);

    result.fold(
      (Failure failure) {
        errorMessage.value = failure.message;
        Get.snackbar("Error".tr, failure.message);
      },
      (FavouriteEntity? entity) {
        favoriteProduct.value = entity;
        // toggleFavorite(productId); // ✅ Cache favorite product
      },
    );

    isLoading.value = false;
  }

  /// **Load cached favorite IDs from secure storage**
  Future<void> loadCachedFavorites() async {
    final storedFavorites = await secureStorage.read(key: 'favorite_products');
    if (storedFavorites != null && storedFavorites.isNotEmpty) {
      cachedFavorites.assignAll(storedFavorites
          .split(',')
          .map((id) => int.tryParse(id) ?? 0)
          .where((id) => id != 0)
          .toList());
    }
  }

  /// **Save updated favorite IDs list to secure storage**
  Future<void> saveCachedFavorites() async {
    await secureStorage.write(
        key: 'favorite_products', value: cachedFavorites.join(','));
  }

  /// **Check if a product is in favorites**
  bool isProductFavorite(int productId) {
    return cachedFavorites.contains(productId);
  }

  /// **Toggle favorite state**
  Future<void> toggleFavorite(int productId) async {
    if (isProductFavorite(productId)) {
      removeProductFromFavorites(productId);
    } else {
      addProductToCachedFavorites(productId);
    }
  }

  /// **Add product to cached favorites**
  Future<void> addProductToCachedFavorites(int productId) async {
    if (!cachedFavorites.contains(productId)) {
      cachedFavorites.add(productId);
      await saveCachedFavorites();
    }
    Get.snackbar("Success".tr, "✅ Product added to favorites".tr);
  }

  /// **Remove a product from cached favorites**
  void removeProductFromFavorites(int productId) {
    cachedFavorites.remove(productId);
    saveCachedFavorites();
    Get.snackbar("Success".tr, "✅ Product removed from favorites".tr);
  }
}
