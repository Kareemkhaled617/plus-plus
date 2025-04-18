import 'package:get/get.dart';
import 'package:plus/app/domain/entities/product_entity.dart';

import '../../../domain/usecases/get_related_products_usecase.dart';

class RelatedProductController extends GetxController {
  final GetRelatedProductsUseCase getRelatedProductsUseCase;

  RelatedProductController(this.getRelatedProductsUseCase);

  RxList<ProductEntity> relatedProducts = <ProductEntity>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchRelatedProducts();
    super.onInit();
  }

  void fetchRelatedProducts() async {
    isLoading.value = true;
    relatedProducts.value = await getRelatedProductsUseCase();
    isLoading.value = false;
  }
}
