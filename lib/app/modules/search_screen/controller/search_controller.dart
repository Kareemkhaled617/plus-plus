import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/search_products_usecase.dart';


class SearchProductController extends GetxController {
  final SearchProductsUseCase searchProductsUseCase;

  SearchProductController(this.searchProductsUseCase);

  var isLoading = false.obs;
  var searchResults = <ProductEntity>[].obs;
  var errorMessage = ''.obs;

  Future<void> searchProducts(String query) async {
    isLoading.value = true;

    final Either<Failure, List<ProductEntity>> result =
    await searchProductsUseCase(query);

    result.fold(
          (Failure failure) {
        errorMessage.value = failure.message;
      },
          (List<ProductEntity> products) {
        searchResults.assignAll(products);
      },
    );

    isLoading.value = false;
  }
}
