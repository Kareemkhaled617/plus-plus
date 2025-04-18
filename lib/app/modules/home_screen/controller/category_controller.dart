import 'package:get/get.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import '../../../domain/entities/category_entity.dart';

class CategoryController extends GetxController {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryController(this.getCategoriesUseCase);

  var categories = <CategoryEntity>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;

    final result = await getCategoriesUseCase();

    result.fold(
          (failure) {
        errorMessage.value = failure.message;
      },
          (data) {
        categories.assignAll(data);
      },
    );

    isLoading.value = false;
  }

}
