import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/loader.dart';
import 'package:plus/app/modules/cart/widget/cart_list_item.dart';
import 'package:plus/app/modules/cart/widget/checkout_summary.dart';
import 'package:plus/app/modules/check_out_screen/widget/payment_options_section.dart';
import 'package:plus/app/modules/check_out_screen/widget/point_widget.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../cart/controller/cart_controller.dart';
import 'controller/check_out_controller.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final CheckoutController checkoutController =
        Get.find<CheckoutController>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AppKeys.orderSummary.tr,
          style: AppFonts.heading1.copyWith(fontSize: 18),
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios_new)),
        flexibleSpace: Container(
          color: AppColors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: cartController.cartItems
                      .map((product) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CartListItem(
                              product: product,
                              fromCart: false,
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 16),
                UsePointSection(),
                SizedBox(height: 16),
                CheckoutSummary(
                  fromCart: false,
                ),
                SizedBox(height: 16),
                PaymentOptionsSection(),
                SizedBox(height: 16),
                Obx(() {
                  return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: checkoutController.isLoading.value
                          ? null
                          : () {
                              checkoutController.createOrder(
                                  userAddress:
                                      cartController.selectedAddress.value!,
                                  paymentMethod: checkoutController
                                      .mapPaymentOptionToApiValue(
                                          checkoutController.options[
                                              checkoutController
                                                  .selectedIndex.value]),
                                  userPoints:
                                      int.parse(checkoutController.point.text));
                            },
                      label: Icon(
                        Icons.payment,
                        size: 26,
                        color: AppColors.white,
                      ),
                      icon: checkoutController.isLoading.value
                          ? SizedBox(
                              height: 30,
                              child: AppLoader(),
                            )
                          : Text(
                              AppKeys.placeOrder.tr,
                              style: AppFonts.heading3.copyWith(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
