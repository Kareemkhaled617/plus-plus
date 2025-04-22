import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../../../data/repositories/address_repository_impl.dart';
import '../../../domain/repositories/address_repository.dart';
import '../../../domain/usecases/get_addresses_usecase.dart';
import '../../../domain/usecases/get_default_address_usecase.dart';
import '../controllor/address_controller.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    // ✅ Register the abstract repository with the implementation
    Get.lazyPut<AddressRepository>(() => AddressRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetDefaultAddressUseCase(Get.find()));
    Get.lazyPut(() => GetAddressesUseCase(Get.find()));
    Get.lazyPut(() => AddressController(Get.find(), Get.find()));
  }
}
