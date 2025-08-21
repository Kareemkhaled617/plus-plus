import 'package:get/get.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_products_by_category_usecase.dart';

class ProductController extends GetxController {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  ProductController(this.getProductsByCategoryUseCase);

  final isLoading = false.obs;
  final products = <ProductEntity>[].obs;
  final errorMessage = ''.obs;

  /// New: holds the banner URL returned with the products
  final categoryBanner = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchProductsByCategory(0);
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await getProductsByCategoryUseCase(categoryId);

    result.fold(
      (Failure failure) {
        errorMessage.value = failure.message;
        products.clear();
        categoryBanner.value = '';
      },
      (Map<String, dynamic> data) {
        final list = (data['products'] as List<ProductEntity>?);
        products.assignAll(list ?? <ProductEntity>[]);
        categoryBanner.value = data['category_banner'] ??'';
      },
    );

    isLoading.value = false;
  }
}
