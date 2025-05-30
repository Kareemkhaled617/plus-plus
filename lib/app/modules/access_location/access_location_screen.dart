import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:plus/app/core/widgets/loader.dart';

import 'controller/location_controller.dart';
import 'widgets/confirmation_bottom_sheet.dart';

class AccessLocationScreen extends StatefulWidget {
  const AccessLocationScreen({super.key});

  @override
  State<AccessLocationScreen> createState() => _AccessLocationScreenState();
}

class _AccessLocationScreenState extends State<AccessLocationScreen> {
  final locationController = Get.put(LocationController());
  LatLng? initialLatLng;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    setupInitialLocation();
  }

  Future<void> setupInitialLocation() async {
    final args = Get.arguments ?? {};
    final isEdit = args['edit'] ?? false;
    final address = args['address'] ?? {};

    if (isEdit) {
      initialLatLng = LatLng(
        double.tryParse(address['lat'].toString()) ?? 0.0,
        double.tryParse(address['lng'].toString()) ?? 0.0,
      );
    } else {
      await locationController
          .getCurrentLocation(); // Wait for current location
      final pos = locationController.currentPosition.value;
      initialLatLng = LatLng(pos?.latitude ?? 0.0, pos?.longitude ?? 0.0);
    }

    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(
        body: Center(child: AppLoader()),
      );
    }

    return Scaffold(
      body: Obx(() {
        if (locationController.isLoading.value) {
          return const Center(child: AppLoader());
        }

        return PlacePicker(
          mapsBaseUrl: "https://maps.googleapis.com/maps/api/",
          usePinPointingSearch: true,
          apiKey: 'AIzaSyC86lWEI5fMklifz509ZmHUyGpj1AuplUA',
          initialLocation: initialLatLng!,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onPlacePicked: (LocationResult result) {
            locationController.selectAddress(
              result.formattedAddress ?? "Unknown Location".tr,
              LatLng(result.latLng!.latitude, result.latLng!.longitude),
              result,
            );
            Get.back();
          },
          onMapCreated: (controller) {
            locationController.mapController.value = controller;
          },
          searchInputConfig: const SearchInputConfig(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            autofocus: false,
          ),
          searchInputDecorationConfig: SearchInputDecorationConfig(
            hintText: "Search for a building, street or ...",
          ),
          selectedPlaceWidgetBuilder: (ctx, state, result) {
            return ConfirmationBottomSheet(
              address: result?.formattedAddress ?? '',
              isSearch: state.name == 'searching'.tr,
              locationController: locationController,
              result: result,
            );
          },
          autocompletePlacesSearchRadius: 150,
          enableNearbyPlaces: false,
          showSearchInput: true,
        );
      }),
    );
  }


}
