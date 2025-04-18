import 'package:get/get.dart';
import '../../../domain/usecases/get_addresses_usecase.dart';
import '../../../domain/entities/address_entity.dart';

class AddressController extends GetxController {
  final GetAddressesUseCase getAddressesUseCase;

  AddressController(this.getAddressesUseCase);

  var addresses = <AddressEntity>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
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
}
