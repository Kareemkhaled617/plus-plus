import 'package:get/get.dart';
import 'package:plus/app/modules/sub_category/controller/product_controller.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import '../../../domain/usecases/get_subcategories_usecase.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../core/errors/failure.dart';

class SupCategoryController extends GetxController {
  final GetSubcategoriesUseCase getSubcategoriesUseCase;

  SupCategoryController(this.getSubcategoriesUseCase);

  ProductController productController = Get.find<ProductController>();
  var isLoading = false.obs;
  var isLoadingSup = false.obs;
  var supSupCategories = <CategoryEntity>[].obs;
  var subcategories = <CategoryEntity>[].obs;
  var errorMessage = ''.obs;
  RxInt selectedCategory = 0.obs;
  RxInt selectedSubcategory = 0.obs;

  @override
  void onInit() {
    fetchSubcategories(Get.arguments['id']);
    super.onInit();
  }

  void fetchSubcategories(int parentId) async {
    isLoading.value = true;
    final result = await getSubcategoriesUseCase(parentId);

    result.fold(
      (Failure failure) => errorMessage.value = failure.message,
      (List<CategoryEntity> data) {
        if (data.isNotEmpty) {
          productController.fetchProductsByCategory(data[0].id);
        }
        return subcategories.assignAll(data);
      },
    );
    if (subcategories.isNotEmpty) {
      fetchSubsSupCategories(subcategories[0].id);
    }

    isLoading.value = false;
  }

  void fetchSubsSupCategories(int parentId) async {
    isLoadingSup.value = true;
    final result = await getSubcategoriesUseCase(parentId);

    result.fold(
      (Failure failure) => errorMessage.value = failure.message,
      (List<CategoryEntity> data) => supSupCategories.assignAll(data),
    );

    isLoadingSup.value = false;
  }
}
