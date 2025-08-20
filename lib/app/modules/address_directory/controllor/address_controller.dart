import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../domain/entities/address_entity.dart';
import '../../../domain/entities/default_address_entity.dart';
import '../../../domain/usecases/get_addresses_usecase.dart';
import '../../../domain/usecases/get_default_address_usecase.dart';

class AddressController extends GetxController {
  final GetAddressesUseCase getAddressesUseCase;

  var addresses = <AddressEntity>[].obs;
  var isLoading = false.obs;
  var isLoadingLocation = false.obs;
  Position? position;
  String? currentAddress;
  Placemark? place;
  final GetDefaultAddressUseCase getDefaultAddressUseCase;

  AddressController(this.getDefaultAddressUseCase, this.getAddressesUseCase);

  var address = Rxn<DefaultAddressEntity>();
  var isLoadingAddress = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
    fetchDefaultAddress();
  }

  void fetchAddresses() async {
    isLoading.value = true;
    await getAddressFromCoordinates();
    final result = await getAddressesUseCase();
    result.fold(
      (failure) => Get.snackbar("Error".tr, failure.message),
      (data) => addresses.assignAll([
        ...data,
        AddressEntity(
            id: 1,
            lat: position!.latitude.toString(),
            lng: position!.longitude.toString(),
            street: place!.street!,
            address: place!.thoroughfare!,
            building: place!.street!,
            floor: 'floor',
            department: 'department',
            setAs: 'current',
            phone: '0')
      ]),
    );
    isLoading.value = false;
  }

  void fetchDefaultAddress() async {
    isLoadingAddress.value = true;

    final result = await getDefaultAddressUseCase();

    result.fold(
      (failure) {
        address.value = null;
      },
      (defaultAddress) {
        address.value = defaultAddress;
      },
    );

    isLoadingAddress.value = false;
  }

  Future<bool> checkAndRequestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentPosition() async {
    bool hasPermission = await checkAndRequestPermission();
    if (!hasPermission) return null;

    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<String?> getAddressFromCoordinates() async {
    position = await getCurrentPosition();
    if (position == null) {
      return null;
    } else {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position!.latitude, position!.longitude);
        if (placemarks.isNotEmpty) {
          place = placemarks.first;
          return "${place!.thoroughfare}";
        }
        return null;
      } catch (e) {
        print("Error in reverse geocoding: $e");
        return null;
      }
    }
  }
}
