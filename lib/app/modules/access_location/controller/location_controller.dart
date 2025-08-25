import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';
import '../../../../generated/assets.dart';
import '../../../core/storage/secure_storage_helper.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/pupup_dialog.dart';
import '../../address_directory/address_directory.dart';

class LocationController extends GetxController {
  var isLoading = true.obs;
  var isLoadingUpdate = false.obs;
  var currentPosition = Rxn<Position>();
  var mapController = Rxn<GoogleMapController>();
  var selectedAddress = ''.obs;
  LocationResult? locationResult;

  // Text controllers for user input
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController streetController = TextEditingController(text: '');
  TextEditingController buildingController = TextEditingController(text: '');
  TextEditingController floorController = TextEditingController(text: '');
  TextEditingController apartmentController = TextEditingController(text: '');

  // Selected option for address type
  RxString selectedOption = "home".obs;
  final List<String> options = [
    "essential",
    "home",
    "work",
    "default",
    "other"
  ];

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Error".tr, "Location services are disabled.".tr);
      isLoading.value = false;
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Error".tr, "Location permission denied.".tr);
        isLoading.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Error".tr, "Location permissions permanently denied.".tr);
      isLoading.value = false;
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition.value = position;
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", "Failed to get location: $e");
      isLoading.value = false;
    }
  }

  void selectAddress(String address, LatLng position, LocationResult result) {
    selectedAddress.value = address;
    locationResult = result;

    if (mapController.value != null) {
      mapController.value!.animateCamera(CameraUpdate.newLatLng(position));
    }

    // Update user input fields
    addressController.text = result.formattedAddress ?? '';
    streetController.text = result.streetNumber?.longName ?? '';
  }

  /// **Save address to API**
  Future<void> updateAddress() async {
    isLoadingUpdate.value = true;

    String? token = await SecureStorageHelper().getData("auth_token");
    print(token);
    var headers = {
      'BusinessId': '1',
      'Authorization': 'Bearer $token',
    };

    var data = {
      "address_lat": locationResult!.latLng!.latitude.toString(),
      "address_long": locationResult!.latLng!.longitude.toString(),
      "type": selectedOption.value,
      "address": selectedAddress.value,
      "street": streetController.text,
      "building": buildingController.text,
      "department": apartmentController.text,
      "floor": floorController.text,
      "phone": phoneController.text,
    };

    try {
      var response = await Dio().patch(
        'https://plusp.msarweb.net/api/addresses/update-address',
        options: Options(headers: headers),
        data: data,
      );
      if (response.statusCode == 200) {
        Get.back();
        showCustomBottomSheet(
            Get.context!,
            Column(
              children: [
                Image.asset(
                  Assets.imagesAccessLocationDone,
                  height: 200,
                  width: 180,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  AppKeys.thankYou.tr,
                  style: AppFonts.heading3.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  AppKeys.weAddedYourAddress.tr,
                  style: AppFonts.heading3.copyWith(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: AppKeys.addressDirectory.tr,
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                )
              ],
            ));
      } else {
        Get.snackbar("Error".tr, "Failed to update address.".tr);

      }
    } catch (e) {
      print('e.toString()');
      print(e.toString());
      // Get.snackbar("Error".tr, "Something went wrong!".tr);
      AppPopup.show(
        Get.context!,
        type: AppPopupType.warning,
        title: 'Missing Information'.tr,
        message: 'Kindly complete all required fields before proceeding.'.tr,
        primaryText: 'OK'.tr,
        onPrimary: () => Get.back(),
      );

    } finally {
      isLoadingUpdate.value = false;
    }
  }
}
