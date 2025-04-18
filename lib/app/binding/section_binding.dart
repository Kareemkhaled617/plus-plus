import 'package:get/get.dart';
import '../core/network/api_service.dart';
import '../data/repositories/section_repository_impl.dart';
import '../domain/repositories/section_repository.dart';
import '../domain/usecases/get_sections_usecase.dart';
import '../modules/home_screen/controller/section_controller.dart';

class SectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<SectionRepository>(
            () => SectionRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<GetSectionsUseCase>(
            () => GetSectionsUseCase(Get.find<SectionRepository>()));

    Get.lazyPut<SectionController>(
            () => SectionController(Get.find<GetSectionsUseCase>()));
  }
}
