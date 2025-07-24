import 'package:get/get.dart';
import '../../../domain/usecases/request_product_point_usecase.dart';
import '../../../domain/entities/point_request_entity.dart';

class ProductPointController extends GetxController {
  final RequestProductPointUseCase requestProductPointUseCase;

  ProductPointController(this.requestProductPointUseCase);

  RxBool isLoading = false.obs;

  Future<void> requestPoint(int productId) async {
    isLoading.value = true;
    final result = await requestProductPointUseCase(
        PointRequestEntity(productId: productId));
    result.fold(
      (failure) => Get.snackbar("Error".tr, failure.message),
      (_) =>
          Get.snackbar("Success".tr, "Thanks you will get notified when product is back in stock".tr),
    );
    isLoading.value = false;
  }
}
