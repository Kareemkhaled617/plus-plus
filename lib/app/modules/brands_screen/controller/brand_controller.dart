import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/entities/brand_entity.dart';
import '../../../domain/usecases/get_brands_usecase.dart';

class BrandController extends GetxController {
  final GetBrandsUseCase getBrandsUseCase;

  BrandController(this.getBrandsUseCase);

  var brands = <BrandEntity>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  Future<void> fetchBrands() async {
    isLoading.value = true;
    final Either<Failure, List<BrandEntity>> result =
        await getBrandsUseCase(Get.arguments['id']);

    result.fold(
      (failure) => errorMessage.value = failure.message,
      (data) {
        brands.value = data;
        errorMessage.value = '';
      },
    );

    isLoading.value = false;
  }
}
