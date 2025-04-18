import 'package:get/get.dart';
import '../../../domain/entities/banner_entity.dart';
import '../../../domain/usecases/get_banners_usecase.dart';

class BannerController extends GetxController {
  final GetBannersUseCase getBannersUseCase;

  BannerController(this.getBannersUseCase);

  RxList<BannerEntity> banners = <BannerEntity>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    isLoading.value = true;
    banners.value = await getBannersUseCase();
    isLoading.value = false;
  }
}
