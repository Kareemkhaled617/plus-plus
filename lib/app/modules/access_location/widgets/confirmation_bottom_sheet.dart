import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/custom_bottom_sheet.dart';
import 'package:plus/app/modules/access_location/widgets/address_details_bottom_sheet.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_fonts.dart';
import '../../../core/utils/app_keys.dart';
import '../../../core/widgets/custom_button.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
          Text(
            AppKeys.accessLocationDescription.tr,
            textAlign: TextAlign.center,
            style: AppFonts.bodyText.copyWith(
              fontSize: 12,
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 20),
          CustomButton(
            miniSize: Size(200, 45),
            text: AppKeys.accessLocation.tr,
            onPressed: () {
              showCustomBottomSheet(context, AddressDetailsBottomSheet());
            },
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
