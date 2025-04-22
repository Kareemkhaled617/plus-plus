import 'package:get/get.dart';
import '../../../domain/entities/default_address_entity.dart';
import '../../../domain/usecases/get_addresses_usecase.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../domain/usecases/get_default_address_usecase.dart';

class AddressController extends GetxController {
  final GetAddressesUseCase getAddressesUseCase;

  var addresses = <AddressEntity>[].obs;
  var isLoading = false.obs;
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
    final result = await getAddressesUseCase();
    result.fold(
      (failure) => Get.snackbar("Error", failure.message),
      (data) => addresses.assignAll(data),
    );
    isLoading.value = false;
  }

  void fetchDefaultAddress() async {
    isLoadingAddress.value = true;

    final result = await getDefaultAddressUseCase();

    result.fold(
      (failure) {
        // Handle failure case (optional: show error message)
        address.value = null;
      },
      (defaultAddress) {
        address.value = defaultAddress;
      },
    );

    isLoadingAddress.value = false;
  }
}
