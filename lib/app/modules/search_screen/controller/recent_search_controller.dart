import 'package:get/get.dart';
import '../../../domain/usecases/get_recent_searches_usecase.dart';
import '../../../domain/entities/recent_search_entity.dart';

class RecentSearchController extends GetxController {
  final GetRecentSearchesUseCase getRecentSearchesUseCase;

  RecentSearchController(this.getRecentSearchesUseCase);

  var isLoading = false.obs;
  var recentSearches = <RecentSearchEntity>[].obs;

  @override
  void onInit() {
    fetchRecentSearches();
    super.onInit();
  }

  Future<void> fetchRecentSearches() async {
    isLoading.value = true;

    final result = await getRecentSearchesUseCase();

    result.fold(
          (failure) => Get.snackbar("Error".tr, failure.message),
          (searches) => recentSearches.value = searches,
    );

    isLoading.value = false;
  }
}
