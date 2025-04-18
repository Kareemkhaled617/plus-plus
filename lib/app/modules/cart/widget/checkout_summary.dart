import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../controller/cart_controller.dart';
import 'cart_price_item.dart';
import 'coupon_section.dart';
import 'delivery_section.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Obx(() {
      // double subtotal = cartController.getSubtotal();
      // double deliveryFee = 50.0; // Set a default delivery fee
      // double total = subtotal + deliveryFee;

      return cartController.isLoading.value
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CartPriceItem(
                  title: AppKeys.subtotal.tr,
                  // price: "${subtotal.toStringAsFixed(2)} L.E",
                  price:
                      "${(cartController.updatedCart.value!.cartPriceData.totalPrice + cartController.updatedCart.value!.cartPriceData.totalDiscount + cartController.updatedCart.value!.cartPriceData.couponDiscount)} L.E",
                ),
                SizedBox(height: 10),
                CartPriceItem(
                  title: AppKeys.delivery.tr,
                  // price: "${deliveryFee.toStringAsFixed(2)} L.E",
                  price:
                      "${cartController.updatedCart.value!.cartPriceData.chargePrice.toStringAsFixed(2)} L.E",
                ),
                SizedBox(height: 10),
                CartPriceItem(
                  title: AppKeys.discount.tr,
                  price:
                      "${cartController.updatedCart.value!.cartPriceData.totalDiscount.toStringAsFixed(2)} L.E",
                  isTotal: true,
                ),
                SizedBox(height: 10),
                CartPriceItem(
                  title: AppKeys.total.tr,
                  price:
                      "${cartController.updatedCart.value!.cartPriceData.totalPrice.toStringAsFixed(2)} L.E",
                  isTotal: true,
                ),
                const SizedBox(height: 60),
                CouponSection(),
                Obx(
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
                ),
                const SizedBox(height: 30),
                CartDeliverySection(),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (cartController.cartItems.isNotEmpty) {
                        // Handle checkout process
                        Get.snackbar("Checkout", "Proceeding to checkout...",
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Get.snackbar("Cart Empty", "Add items to checkout",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.red,
                            colorText: Colors.white);
                      }
                    },
                    label: Icon(
                      Icons.shopping_cart_outlined,
                      size: 26,
                      color: AppColors.white,
                    ),
                    icon: Text(
                      AppKeys.checkout.tr,
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
                ),
              ],
            );
    });
  }
}
