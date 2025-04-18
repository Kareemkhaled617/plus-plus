import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/brand_repository_impl.dart';
import '../../../domain/repositories/brand_repository.dart';
import '../../../domain/usecases/get_brands_usecase.dart';
import '../controller/brand_controller.dart';

class BrandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<BrandRepository>(
        () => BrandRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<GetBrandsUseCase>(() => GetBrandsUseCase(
          repository: Get.find<BrandRepository>(),
        ));

    Get.put(BrandController(Get.find<GetBrandsUseCase>()));
  }
}
