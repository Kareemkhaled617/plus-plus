import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:plus/app/core/theme/app_fonts.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/core/utils/common_widgets.dart';
import 'package:plus/app/core/widgets/custom_bottom_sheet.dart';
import 'package:plus/app/core/widgets/custom_button.dart';
import 'package:plus/app/core/widgets/custom_text_form_field.dart';
import 'package:plus/app/modules/access_location/controller/location_controller.dart';
import 'package:plus/app/modules/access_location/widgets/destination_selection.dart';
import 'package:plus/app/modules/address_directory/address_directory.dart';

import '../../../../generated/assets.dart';

class AddressDetailsBottomSheet extends StatelessWidget {
  const AddressDetailsBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(LocationController());
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 21),

            /// Location Input
            CustomTextFormField(
              controller: locationController.addressController,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     return 'Please enter your location';
              //   }
              // },
              prefixIcon: Icon(
                Icons.location_on,
                color: AppColors.red,
              ),
              suffixIcon: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset(Assets.iconsEdit),
              ),
              hintText: AppKeys.location.tr,
              fillColor: AppColors.babyBlue,
            ),
            SizedBox(height: 12),

            /// Other Address Fields
            CustomTextFormField(
              hintText: AppKeys.street.tr,
              controller: locationController.streetController,
              fillColor: AppColors.babyBlue,
            ),
            SizedBox(height: 12),
            CustomTextFormField(
              hintText: AppKeys.theBuilding.tr,
              controller: locationController.buildingController,
              fillColor: AppColors.babyBlue,
            ),
            SizedBox(height: 12),
            CustomTextFormField(
              hintText: AppKeys.floor.tr,
              fillColor: AppColors.babyBlue,
              controller: locationController.floorController,
            ),
            SizedBox(height: 12),
            CustomTextFormField(
                hintText: AppKeys.theApartment.tr,
                controller: locationController.apartmentController,
                keyboardType: TextInputType.number,
                fillColor: AppColors.babyBlue),
            SizedBox(height: 12),

            CustomTextFormField(
              hintText: AppKeys.phoneNumber.tr,
              fillColor: AppColors.babyBlue,
              keyboardType: TextInputType.phone,
              controller: locationController.phoneController,
            ),
            SizedBox(height: 12),
            /// Destination Selection
            DestinationSelection(),
            SizedBox(height: 21),

            /// Save Button
            Align(
              alignment: Alignment.center,
              child: Obx(() {
                return CustomButton(
                  text: AppKeys.saveAddress.tr,
                  isEnabled: !locationController.isLoadingUpdate.value,
                  onPressed: () async {
                    await locationController.updateAddress();

                  },
                );
              }),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
