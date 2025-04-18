import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/entities/brand_entity.dart';
import '../../../domain/entities/offer_entity.dart';
import '../../../domain/usecases/get_brands_by_offer_usecase.dart';
import '../../../domain/usecases/get_offers_usecase.dart';

class OfferController extends GetxController {
  final GetOffersUseCase getOffersUseCase;
  final GetBrandsByOfferUseCase getBrandsByOfferUseCase;

  OfferController(this.getOffersUseCase, this.getBrandsByOfferUseCase);

  var isLoading = false.obs;
  var isLoadingBrand = false.obs;
  var offers = <OfferEntity>[].obs;
  var errorMessage = ''.obs;
  var brands = <BrandEntity>[].obs;
  Rx<BrandEntity>? selectedValue;

  @override
  void onInit() {
    fetchOffers();
    super.onInit();
  }

  Future<void> fetchOffers() async {
    isLoading.value = true;
    final Either<Failure, List<OfferEntity>> result = await getOffersUseCase();

    result.fold(
      (failure) => errorMessage.value = failure.message,
      (data) {
        offers.value = data;
        errorMessage.value = '';
      },
    );

    isLoading.value = false;
  }

  Future<void> fetchBrandsByOffer(int offerId) async {
    isLoadingBrand.value = true;
    final Either<Failure, List<BrandEntity>> result =
        await getBrandsByOfferUseCase(offerId);

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (brandList) {
        brands.assignAll(brandList);
      },
    );

    isLoadingBrand.value = false;
  }
}
