import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/cart/widget/cart_empty_body.dart';
import 'package:plus/app/modules/cart/widget/cart_header.dart';
import 'package:plus/app/modules/cart/widget/cart_list_item.dart';
import 'package:plus/app/modules/cart/widget/checkout_button.dart';

import '../../core/theme/app_colors.dart';
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return cartController.cartItems.isNotEmpty
                    ? MyCartHeader(
                  itemCount: cartController.cartItems.length,
                  onClear: () {
                   cartController.clearCart();
                  },
                )
                    : Container();
              }),
              // RelatedProductsList(),
              // SizedBox(height: 30),
              // Text(
              //   AppKeys.cartProducts.tr,
              //   style: AppFonts.heading1.copyWith(fontSize: 18),
              // ),
              // SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 12.0),
                child: Column(
                  children: [
                    Column(
                      children: cartController.cartItems
                          .map((product) =>
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: CartListItem(
                              product: product,
                              fromCart: true,
                            ),
                          ))
                          .toList(),
                    ),
                          // CheckoutSummary(
                          //   fromCart: true,
                          // ),
                          // SizedBox(height: 16),
                          // const SizedBox(height: 20),

                          // Stack(
                          //   children: [
                          //     Obx(
                          //             () {
                          //           return CheckoutButton(
                          //               total: cartController.isLoading.value
                          //                   ? ""
                          //                   : "${(cartController.updatedCart.value!
                          //                   .cartPriceData.totalPrice +
                          //                   cartController.updatedCart.value!
                          //                       .cartPriceData.totalDiscount +
                          //                   cartController.updatedCart.value!
                          //                       .cartPriceData.couponDiscount)} L.E",
                          //               onPressed: cartController
                          //               .isLoadingTotalCart.value
                          //               ? ()
                          //           {}: () async {
                          //           await cartController.fetchCartTotal(
                          //           cartController
                          //               .selectedAddress.value!.lat,
                          //           cartController
                          //               .selectedAddress.value!.lng);
                          //           Get.toNamed(AppRoutes.checkOutScreen);
                          //           },
                          //           );
                          //         }
                          //     ),
                          //     cartController.isLoadingTotalCart.value
                          //         ? AppLoader()
                          //         : Container()
                          //   ],
                          // ),
                          // Align(
                          //   alignment: Alignment.center,
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     child: CustomButton(
                    //       isEnabled:
                    //           !cartController.isLoadingTotalCart.value,
                    //       text: AppKeys.checkout.tr,
                    //       onPressed: () async {
                    //         if (cartController.selectedAddress.value !=
                    //             null) {
                    //           await cartController.fetchCartTotal(
                    //               cartController
                    //                   .selectedAddress.value!.lat,
                    //               cartController
                    //                   .selectedAddress.value!.lng);
                    //           Get.toNamed(AppRoutes.checkOutScreen);
                    //         } else {
                    //           Get.snackbar("Address Empty".tr,
                    //               "please select address".tr,
                    //               snackPosition: SnackPosition.TOP,
                    //               colorText: Colors.black);
                    //         }
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                    ),
            ],
                ),
              ),
              bottomNavigationBar: Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: CheckoutButton(
                    total: cartController.isLoading.value
                        ? ""
                        : "${(cartController.updatedCart.value!.cartPriceData.totalPrice + cartController.updatedCart.value!.cartPriceData.totalDiscount + cartController.updatedCart.value!.cartPriceData.couponDiscount)} L.E",
                    onPressed: cartController.isLoadingTotalCart.value
                        ? () {}
                        : () async {
                            await cartController.fetchCartTotal('0', '0', '0');
                            Get.toNamed(AppRoutes.checkOutScreen);
                          },
                  ),
                );
              }),
            )
          : const CartEmptyBody();
    });
  }
}
