import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_colors.dart';
import 'package:plus/app/core/theme/app_fonts.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/core/utils/common_widgets.dart';
import 'package:plus/app/core/widgets/custom_bottom_sheet.dart';
import 'package:plus/app/core/widgets/custom_button.dart';
import 'package:plus/app/core/widgets/custom_text_form_field.dart';
import 'package:plus/app/modules/access_location/widgets/destination_selection.dart';
import 'package:plus/app/modules/address_directory/address_directory.dart';

import '../../../../generated/assets.dart';
import 'package:flutter/material.dart';

class AddressDetailsBottomSheet extends StatelessWidget {
  AddressDetailsBottomSheet({super.key});

  final TextEditingController locationController =
      TextEditingController(text: "Cairo, El-Gash street build 4");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 21),

            /// Location Input
            CustomTextFormField(
              controller: locationController,
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
              fillColor: AppColors.babyBlue,
            ),
            SizedBox(height: 12),
            CustomTextFormField(
              hintText: AppKeys.theBuilding.tr,
              fillColor: AppColors.babyBlue,
            ),
            SizedBox(height: 12),
            CustomTextFormField(
                hintText: AppKeys.floor.tr, fillColor: AppColors.babyBlue),
            SizedBox(height: 12),
            CustomTextFormField(
                hintText: AppKeys.theApartment.tr, fillColor: AppColors.babyBlue),
            SizedBox(height: 12),

            /// Destination Selection
            DestinationSelection(),
            SizedBox(height: 21),

            /// Save Button
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                text: AppKeys.saveAddress.tr,
                onPressed: () {
                  Get.back();
                  showCustomBottomSheet(
                    context,
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
                          "Ali ${AppKeys.weAddedYourAddress.tr}",
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
                            Get.off(AddressDirectory());
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
