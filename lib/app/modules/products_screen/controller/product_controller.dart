import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_products_by_brand_usecase.dart';
import '../../../domain/usecases/get_products_by_section_usecase.dart';

class ProductController extends GetxController {
  final GetProductsByBrandUseCase getProductsByBrandUseCase;
  final GetProductsBySectionUseCase getProductsBySectionUseCase;

  ProductController(
      this.getProductsByBrandUseCase, this.getProductsBySectionUseCase);

  var products = <ProductEntity>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  onInit() {
    if (Get.arguments['isSection']) {
      fetchProductsBySection(Get.arguments['id']);
    } else {
      fetchProductsByBrand(Get.arguments['id']);
    }

    super.onInit();
  }

  Future<void> fetchProductsByBrand(int id) async {
    isLoading.value = true;
    final Either<Failure, List<ProductEntity>> result =
        await getProductsByBrandUseCase(id);

    result.fold(
      (failure) => errorMessage.value = failure.message,
      (data) {
        products.value = data;
        errorMessage.value = '';
      },
    );

    isLoading.value = false;
  }

  Future<void> fetchProductsBySection(int sectionId) async {
    isLoading.value = true;
    final Either<Failure, List<ProductEntity>> result =
        await getProductsBySectionUseCase(sectionId);

    result.fold(
      (failure) => errorMessage.value = failure.message,
      (data) {
        products.value = data;
        errorMessage.value = '';
      },
    );

    isLoading.value = false;
  }
}
