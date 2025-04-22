import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:plus/app/core/widgets/loader.dart';
import '../address_directory/controllor/address_controller.dart';
import 'controller/location_controller.dart';
import 'widgets/confirmation_bottom_sheet.dart';

class AccessLocationScreen extends StatelessWidget {
  const AccessLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationController());
    final args = Get.arguments ?? {};
    final isEdit = args['edit'] ?? false;
    final address = args['address'] ?? {};
    print(isEdit);
    print(isEdit);
    print(isEdit);
    print(address);
    print(address);
    final initialLatLng = isEdit
        ? LatLng(
            double.tryParse(address['lat'].toString()) ?? 0.0,
            double.tryParse(address['lng'].toString()) ?? 0.0,
          )
        : LatLng(
            locationController.currentPosition.value?.latitude ?? 0.0,
            locationController.currentPosition.value?.longitude ?? 0.0,
          );
    return Scaffold(
      body: Obx(
        () => locationController.isLoading.value
            ? const Center(child: AppLoader())
            : Stack(
                children: [
                  PlacePicker(
                    mapsBaseUrl: "https://maps.googleapis.com/maps/api/",
                    usePinPointingSearch: true,
                    apiKey: 'AIzaSyC86lWEI5fMklifz509ZmHUyGpj1AuplUA',
                    onPlacePicked: (LocationResult result) {
                      locationController.selectAddress(
                          result.formattedAddress ?? "Unknown Location".tr,
                          LatLng(result.latLng!.latitude,
                              result.latLng!.longitude),
                          result);
                      Get.back();
                    },
                    enableNearbyPlaces: false,
                    showSearchInput: true,
                    initialLocation: initialLatLng,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (controller) {
                      locationController.mapController.value = controller;
                    },
                    searchInputConfig: const SearchInputConfig(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      autofocus: false,
                      textDirection: TextDirection.ltr,
                    ),
                    searchInputDecorationConfig: SearchInputDecorationConfig(
                      hintText: "Search for a building, street or ...".tr,
                    ),
                    selectedPlaceWidgetBuilder: (ctx, state, result) {
                      return ConfirmationBottomSheet(
                        address: result != null ? result.formattedAddress : '',
                        isSearch: state.name == 'searching'.tr,
                        locationController: locationController,
                        result: result,
                      );
                    },
                    autocompletePlacesSearchRadius: 150,
                  ),
                ],
              ),
      ),
    );
  }
}
