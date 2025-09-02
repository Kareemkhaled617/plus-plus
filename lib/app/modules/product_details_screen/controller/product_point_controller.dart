import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/generated/assets.dart';

import '../../../domain/entities/point_request_entity.dart';
import '../../../domain/usecases/request_product_point_usecase.dart';

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
      (_) => showBackInStockSheet(Get.context!),
    );
    isLoading.value = false;
  }

  Future<void> showBackInStockSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Image(image: AssetImage(Assets.iconsProductNoti),width: 80,),
              const SizedBox(height: 12),
              Text(
                'Thanks you will get notified when product\nis back'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.35,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
