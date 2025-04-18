import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/banner_repository_impl.dart';
import '../../../domain/repositories/banner_repository.dart';
import '../../../domain/usecases/get_banners_usecase.dart';
import '../controller/banner_controller.dart';

class BannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<BannerRepository>(() => BannerRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetBannersUseCase(Get.find()));
    Get.lazyPut(() => BannerController(Get.find()));
  }
}
