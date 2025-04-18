import 'package:get/get.dart';
import '../../../core/errors/failure.dart';
import '../../../data/models/package_type_model.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/get_product_details_usecase.dart';

class ProductDetailsController extends GetxController {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsController(this.getProductDetailsUseCase);

  Rx<PackageTypeModel?> selected = Rxn<PackageTypeModel>();
  var isLoading = false.obs;
  var isSelected = false.obs;
  var product = Rxn<ProductEntity>();
  var errorMessage = ''.obs;

  @override
  onInit() {
    super.onInit();
    fetchProduct(Get.arguments['productId']);
  }

  Future<void> fetchProduct(int productId) async {
    isLoading.value = true;
    isSelected.value = false;
    final result = await getProductDetailsUseCase(productId);
    result.fold(
      (Failure failure) => errorMessage.value = failure.message,
      (ProductEntity data) => product.value = data,
    );

    isLoading.value = false;
  }
}
