import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../controller/cart_controller.dart';
import 'cart_price_item.dart';
import 'coupon_section.dart';
import 'delivery_section.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key, required this.fromCart});

  final bool fromCart;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fromCart
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Text("Payment details".tr, style: AppFonts.heading2),
                ),
          CartPriceItem(
            title: AppKeys.subtotal.tr,
            // price: "${subtotal.toStringAsFixed(2)} L.E",
            price: cartController.isLoading.value
                ? ""
                : "${(cartController.updatedCart.value!.cartPriceData.totalPrice + cartController.updatedCart.value!.cartPriceData.totalDiscount + cartController.updatedCart.value!.cartPriceData.couponDiscount)} L.E",
          ),
          SizedBox(height: 10),
          CartPriceItem(
            title: AppKeys.delivery.tr,
            // price: "${deliveryFee.toStringAsFixed(2)} L.E",
            price: cartController.isLoading.value
                ? ""
                : "${cartController.updatedCart.value!.cartPriceData.chargePrice.toStringAsFixed(2)} L.E",
          ),
          SizedBox(height: 10),
          CartPriceItem(
            title: AppKeys.discount.tr,
            price: cartController.isLoading.value
                ? ""
                : "${cartController.updatedCart.value!.cartPriceData.totalDiscount.toStringAsFixed(2)} L.E",
            isTotal: true,
          ),
          SizedBox(height: 10),
          CartPriceItem(
            title: AppKeys.couponDiscount.tr,
            price: cartController.isLoading.value
                ? ""
                : "${cartController.updatedCart.value!.cartPriceData.couponDiscount.toStringAsFixed(2)} L.E",
            isTotal: true,
          ),
          SizedBox(height: 10),
          CartPriceItem(
            title: AppKeys.total.tr,
            price: cartController.isLoading.value
                ? ""
                : "${cartController.updatedCart.value!.cartPriceData.totalPriceAfterCharge.toStringAsFixed(2)} L.E",
            isTotal: true,
          ),
          fromCart ? const SizedBox(height: 60) : SizedBox(height: 20),
          fromCart
              ? Obx(
                  () => cartController.copounText.value.isEmpty
                      ? CouponSection()
                      : Row(
                          children: [
                            const Icon(
                              Icons.discount,
                              color: AppColors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppKeys.appliedCoupon,
                              style: AppFonts.bodyText.copyWith(
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ), // hide UI completely
                )
              : Container(),
          fromCart
              ? Obx(
                  () => cartController.copounText.value.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.green),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.local_offer,
                                      color: AppColors.green,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      cartController.copounText.value,
                                      style: AppFonts.bodyText.copyWith(
                                        color: AppColors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartController.copounController
                                        .clear(); // 🔁 auto updates
                                    cartController.addToCartApi();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: AppColors.red,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(), // hide UI completely
                )
              : Container(),
          fromCart ? const SizedBox(height: 30) : Container(),
          CartDeliverySection(
            fromCart: fromCart,
          ),

        ],
      );
    });
  }
}
