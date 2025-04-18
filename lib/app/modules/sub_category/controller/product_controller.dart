import 'package:get/get.dart';
import '../../../domain/usecases/get_products_by_category_usecase.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../core/errors/failure.dart';

class ProductController extends GetxController {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  ProductController(this.getProductsByCategoryUseCase);

  var isLoading = false.obs;
  var products = <ProductEntity>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    // fetchProductsByCategory(0);
    super.onInit();
  }

  void fetchProductsByCategory(int categoryId) async {
    isLoading.value = true;
    final result = await getProductsByCategoryUseCase(categoryId);

    result.fold(
      (Failure failure) => errorMessage.value = failure.message,
      (List<ProductEntity> data) => products.assignAll(data),
    );

    isLoading.value = false;
  }
}
