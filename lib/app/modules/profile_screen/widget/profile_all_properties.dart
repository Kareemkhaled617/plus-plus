import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/custom_bottom_sheet.dart';
import 'package:plus/app/modules/all_prescription/all_prescription_screen.dart';
import 'package:plus/app/modules/profile_screen/widget/logout_bottom_sheet_content.dart';
import 'package:plus/app/modules/profile_screen/widget/profile_property_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_keys.dart';
import '../../account_screen/account_screen.dart';
import '../../address_directory/address_directory.dart';

class ProfileAllProperties extends StatelessWidget {
  const ProfileAllProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: .5,
          color: AppColors.greyWithShade.withOpacity(.2),
        ),
        ProfilePropertyCard(
          title: AppKeys.account.tr,
          subtitle: AppKeys.personalInfo.tr,
          icon: Icons.person_2_rounded,
          iconColor: AppColors.primary,
          onTap: () {
            Get.to(AccountScreen());
          },
        ),
        ProfilePropertyCard(
          title: AppKeys.addressDirectory.tr,
          subtitle: AppKeys.shippingInfo.tr,
          icon: Icons.pin_drop_outlined,
          onTap: () {
            Get.to(const AddressDirectory());
          },
        ),
        ProfilePropertyCard(
          title: AppKeys.myPrescriptions.tr,
          icon: Icons.event_note_outlined,
          onTap: () {
            Get.to(AllPrescriptionScreen());
          },
        ),
        ProfilePropertyCard(
          title: AppKeys.appEvaluation.tr,
          icon: Icons.star,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: AppKeys.shareApp.tr,
          icon: Icons.share_outlined,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: AppKeys.termsAndConditions.tr,
          icon: Icons.security_rounded,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: AppKeys.privacyPolicy.tr,
          icon: Icons.privacy_tip_outlined,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: AppKeys.language.tr,
          icon: Icons.language_outlined,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: AppKeys.logout.tr,
          icon: Icons.logout,
          iconColor: AppColors.red,
          onTap: () {
            showCustomBottomSheet(
              context,
              LogoutBottomSheetContent(),
            );
          },
        ),
      ],
    );
  }
}
