import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker_google/place_picker_google.dart';
import 'package:plus/app/core/widgets/custom_bottom_sheet.dart';
import 'package:plus/app/core/widgets/loader.dart';
import 'package:plus/app/modules/access_location/controller/location_controller.dart';
import 'package:plus/app/modules/access_location/widgets/address_details_bottom_sheet.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/widgets/custom_button.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet(
      {super.key,
      required this.address,
      required this.isSearch,
      required this.locationController,
      this.result});

  final String? address;
  final bool isSearch;
  final LocationController locationController;
  final LocationResult? result;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppKeys.confirmYourLocation.tr,
            style: AppFonts.heading3.copyWith(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          isSearch
              ? SizedBox(height: 60, child: AppLoader())
              : Text(
                  address ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: AppFonts.bodyText.copyWith(
                    fontSize: 16,
                    color: AppColors.grey,
                  ),
                ),
          SizedBox(height: 20),
          CustomButton(
            miniSize: Size(200, 45),
            text: AppKeys.accessLocation.tr,
            isEnabled: !isSearch,
            onPressed: () {
              locationController.selectAddress(
                  result!.formattedAddress ?? "Unknown Location",
                  LatLng(result!.latLng!.latitude, result!.latLng!.longitude),
                  result!);
              showCustomBottomSheet(context, AddressDetailsBottomSheet());
            },
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
