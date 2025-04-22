import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/loader.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/widgets/app_bar_back_button.dart';
import '../../core/utils/app_keys.dart';
import '../../routes/app_routes.dart';
import 'address_card.dart';
import 'controllor/address_controller.dart';

class AddressDirectory extends StatefulWidget {
  const AddressDirectory({super.key});

  @override
  State<AddressDirectory> createState() => _AddressDirectoryState();
}

class _AddressDirectoryState extends State<AddressDirectory> {
  final controller = Get.find<AddressController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAddresses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: AppBarBackButton(),
        backgroundColor: AppColors.white,
        title: Text(AppKeys.addressDirectory.tr, style: AppFonts.heading1),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: AppLoader());
        }
        if (controller.addresses.isEmpty) {
          return Center(child: Text("No addresses found".tr));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.addresses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final address = controller.addresses[index];
            return AddressCard(address: address);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.toNamed(AppRoutes.accessLocationScreen,
              arguments: {'edit': false});
        },
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
