import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/recent_search_repository_impl.dart';
import '../../../domain/usecases/get_recent_searches_usecase.dart';
import '../controller/recent_search_controller.dart';

class RecentSearchBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = ApiService();
    final repository = RecentSearchRepositoryImpl(apiService);
    final useCase = GetRecentSearchesUseCase(repository);
    Get.put(RecentSearchController(useCase));
  }
}
