import 'package:get/get.dart';
import '../core/network/api_service.dart';
import '../data/repositories/category_repository_impl.dart';
import '../domain/repositories/category_repository.dart';
import '../domain/usecases/get_subcategories_usecase.dart';
import '../modules/sub_category/controller/sup_category_controller.dart';

class SupCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<CategoryRepository>(
            () => CategoryRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<GetSubcategoriesUseCase>(
            () => GetSubcategoriesUseCase(Get.find<CategoryRepository>()));

    Get.lazyPut<SupCategoryController>(
            () => SupCategoryController(Get.find<GetSubcategoriesUseCase>()));
  }
}
