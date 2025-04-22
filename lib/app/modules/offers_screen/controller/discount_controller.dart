import 'package:get/get.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_discount_products_usecase.dart';

class DiscountController extends GetxController {
  final GetDiscountProductsUseCase getDiscountProductsUseCase;

  DiscountController(this.getDiscountProductsUseCase);

  var isLoading = false.obs;
  var discountProducts = <ProductEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDiscountProducts();
  }

  void fetchDiscountProducts() async {
    isLoading.value = true;

    final result = await getDiscountProductsUseCase();
    result.fold(
      (failure) => Get.snackbar('Error'.tr, failure.message),
      (products) => discountProducts.value = products,
    );

    isLoading.value = false;
  }
}
