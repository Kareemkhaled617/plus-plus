import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/brand_repository_impl.dart';
import '../../../data/repositories/offer_repository_impl.dart';
import '../../../domain/repositories/brand_repository.dart';
import '../../../domain/repositories/offer_repository.dart';
import '../../../domain/usecases/get_brands_by_offer_usecase.dart';
import '../../../domain/usecases/get_offers_usecase.dart';
import '../controller/offer_controller.dart';

class OfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<OfferRepository>(
        () => OfferRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<BrandRepository>(
        () => BrandRepositoryImpl(Get.find<ApiService>()));

    Get.lazyPut<GetOffersUseCase>(
        () => GetOffersUseCase(repository: Get.find<OfferRepository>()));
    Get.lazyPut<GetBrandsByOfferUseCase>(
        () => GetBrandsByOfferUseCase(Get.find<BrandRepository>()));

    Get.put(OfferController(
        Get.find<GetOffersUseCase>(), Get.find<GetBrandsByOfferUseCase>()));
  }
}
