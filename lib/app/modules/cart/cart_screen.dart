import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/custom_button.dart';
import 'package:plus/app/modules/cart/widget/cart_empty_body.dart';
import 'package:plus/app/modules/cart/widget/cart_list_item.dart';
import 'package:plus/app/modules/cart/widget/checkout_summary.dart';
import 'package:plus/app/modules/cart/widget/related_products_list.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../routes/app_routes.dart';
import '../cart/controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cartController.cartItems.isNotEmpty) {
        cartController.addToCartApi();
      }
    });

    return Obx(() {
      return cartController.cartItems.isNotEmpty
          ? Scaffold(
              backgroundColor: AppColors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RelatedProductsList(),
                        SizedBox(height: 30),
                        Text(
                          AppKeys.cartProducts.tr,
                          style: AppFonts.heading1.copyWith(fontSize: 18),
                        ),
                        SizedBox(height: 12),
                        Column(
                          children: cartController.cartItems
                              .map((product) => Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: CartListItem(
                                      product: product,
                                      fromCart: true,
                                    ),
                                  ))
                              .toList(),
                        ),
                        SizedBox(height: 16),
                        CheckoutSummary(
                          fromCart: true,
                        ),
                        SizedBox(height: 16),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                            isEnabled: !cartController.isLoadingTotalCart.value,
                            text: AppKeys.checkout.tr,
                            onPressed:  () async {
                                    if (cartController.selectedAddress.value !=
                                        null) {
                                      await cartController.fetchCartTotal(
                                          cartController
                                              .selectedAddress.value!.lat,
                                          cartController
                                              .selectedAddress.value!.lng);
                                      Get.toNamed(AppRoutes.checkOutScreen);
                                    } else {
                                      Get.snackbar("Address Empty".tr,
                                          "please select address".tr,
                                          snackPosition: SnackPosition.TOP,
                                          colorText: Colors.black);
                                    }
                                  },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const CartEmptyBody();
    });
  }
}
