import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/core/widgets/custom_text_form_field.dart';
import 'package:plus/app/modules/access_location/widgets/access_location_map.dart';
import 'package:plus/app/modules/access_location/widgets/confirmation_bottom_sheet.dart';
import 'package:plus/generated/assets.dart';


class AccessLocationScreen extends StatefulWidget {
  const AccessLocationScreen({super.key});

  @override
  State<AccessLocationScreen> createState() => _AccessLocationScreenState();
}

class _AccessLocationScreenState extends State<AccessLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Map Background
          AccessLocationMap(onLocationPicked: () {}),

          /// Floating Search Bar
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: CustomTextFormField(
              hintText: AppKeys.searchForLocation.tr,
              prefixIcon: Image.asset(
                Assets.iconsSearch,
              ),
            ),
          ),

          /// Confirmation Bottom Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ConfirmationBottomSheet(),
          ),
        ],
      ),
    );
  }
}
