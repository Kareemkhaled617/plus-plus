import 'package:get/get.dart';
import 'controller/landing_controller.dart';


class LandingBinding extends Bindings {
  @override
  void dependencies() {
    // Keep controller alive as long as needed
    Get.lazyPut<LandingController>(() => LandingController(), fenix: true);
  }
}
