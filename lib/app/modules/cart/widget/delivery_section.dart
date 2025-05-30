import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/modules/address_directory/controllor/address_controller.dart';
import 'package:plus/app/modules/cart/controller/cart_controller.dart';
import 'package:plus/generated/assets.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../routes/app_routes.dart';

class CartDeliverySection extends StatelessWidget {
  const CartDeliverySection({super.key, required this.fromCart});

  final bool fromCart;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppKeys.deliveryTo.tr,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: fromCart
                ? () {
                    showAddressSelectionSheet(context); // 👈 تفتح Bottom Sheet
                  }
                : null,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.babyBlue.withOpacity(.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    Assets.iconsHome,
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.selectedAddress.value != null
                              ? controller.selectedAddress.value!.setAs
                              : AppKeys.addressDirectory.tr,
                          style: AppFonts.bodyText,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.selectedAddress.value != null
                              ? controller.selectedAddress.value!.address
                              : "Choose your delivery address".tr,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  fromCart
                      ? const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 24, color: AppColors.primary)
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  void showAddressSelectionSheet(BuildContext context) {
    final cartController = Get.find<CartController>();
    final addressController = Get.find<AddressController>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose your delivery address".tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // القائمة
                  Expanded(
                    child: Obx(() {
                      if (cartController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (addressController.addresses.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              Text(
                                "No addresses found".tr,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FloatingActionButton(
                                    shape: const CircleBorder(),
                                    onPressed: () {
                                      Get.toNamed(AppRoutes.accessLocationScreen,
                                          arguments: {'edit': false});
                                    },
                                    backgroundColor: AppColors.primary,
                                    child: const Icon(Icons.add,
                                        color: AppColors.white),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        controller: scrollController,
                        itemCount: addressController.addresses.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final address = addressController.addresses[index];
                          final isSelected =
                              cartController.selectedAddress.value?.id ==
                                  address.id;
                          return RadioListTile<AddressEntity>(
                            value: address,
                            groupValue: cartController.selectedAddress.value,
                            onChanged: (value) {
                              cartController.selectAddress(value!);
                              Navigator.pop(context);
                            },
                            title: Text(
                              address.setAs,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(address.address),
                            activeColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: isSelected
                                ? Colors.blue.shade50
                                : Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
