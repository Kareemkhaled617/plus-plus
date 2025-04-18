import 'package:get/get.dart';

import '../core/network/api_service.dart';
import '../data/repositories/category_repository_impl.dart';
import '../domain/usecases/get_categories_usecase.dart';
import '../modules/home_screen/controller/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = ApiService();
    final repository = CategoryRepositoryImpl(apiService);
    final useCase = GetCategoriesUseCase(repository);
    Get.put(CategoryController(useCase));
  }
}
