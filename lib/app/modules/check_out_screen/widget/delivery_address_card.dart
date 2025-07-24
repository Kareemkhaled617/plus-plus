import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plus/app/core/theme/app_colors.dart';

import '../../../domain/entities/address_entity.dart';
import '../../../routes/app_routes.dart';
import '../../address_directory/controllor/address_controller.dart';
import '../../cart/controller/cart_controller.dart';

class DeliveryAddressCard extends StatelessWidget {
  final CartController controller;

  const DeliveryAddressCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      AddressEntity? address = controller.selectedAddress.value;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: SizedBox(
                height: 130,
                width: double.infinity,
                child: address != null
                    ? GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.tryParse(address.lat)!,
                            double.tryParse(address.lng)!,
                          ),
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('delivery_location'),
                            position: LatLng(
                              double.tryParse(address.lat)!,
                              double.tryParse(address.lng)!,
                            ),
                          )
                        },
                        zoomControlsEnabled: false,
                        liteModeEnabled: true,
                        // only on Android
                        myLocationButtonEnabled: false,
                        scrollGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                      )
                    : const Center(child: Text("No location selected")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text(
                        'Delivery address'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_right_alt_rounded,
                          color: Colors.red),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          address != null
                              ? '${address.department} - ${address.street} , ${address.floor}'
                              : 'No address selected',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          address?.address ?? 'No address details available',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Text(
                          'Mobile number 01157446858',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showAddressSelectionSheet(context);
                        },
                        child:  Text(
                          'change'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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
