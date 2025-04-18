import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_products_by_offer_and_brand_usecase.dart';

class ProductOffersController extends GetxController {
  final GetProductsByOfferAndBrandUseCase getProductsByOfferAndBrandUseCase;

  ProductOffersController({required this.getProductsByOfferAndBrandUseCase});

  var isLoading = false.obs;
  var products = <ProductEntity>[].obs;
  var errorMessage = ''.obs;

  @override
  onInit() {
    fetchProductsByOfferAndBrand(
        Get.arguments['offerId'], Get.arguments['brandId']);
    super.onInit();
  }

  Future<void> fetchProductsByOfferAndBrand(int offerId, int brandId) async {
    isLoading.value = true;
    final Either<Failure, List<ProductEntity>> result =
        await getProductsByOfferAndBrandUseCase(offerId, brandId);

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (productList) {
        products.assignAll(productList);
      },
    );

    isLoading.value = false;
  }
}
