import 'package:flutter/material.dart';
import 'package:plus/screen/profile_screen/widget/profile_property_card.dart';

import '../../../utils/app_colors.dart';

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
          title: "Account",
          subtitle: "Personal Information",
          icon: Icons.person_2_rounded,
          iconColor: AppColors.primary,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: "Address directory",
          subtitle: "Shipping Information",
          icon: Icons.pin_drop_outlined,
          onTap: () {},
        ),

        ProfilePropertyCard(
          title: "My Prescriptions",
          icon: Icons.event_note_outlined,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: "App Evaluations",
          icon: Icons.star,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: "Share Application",
          icon: Icons.share_outlined,
          onTap: () {},
        ),




        ProfilePropertyCard(
          title: "Terms of Service",
          icon: Icons.security_rounded,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: "Privacy Policy",
          icon: Icons.privacy_tip_outlined,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: "Language",
          icon: Icons.language_outlined,
          onTap: () {},
        ),
        ProfilePropertyCard(
          title: "Logout",
          icon: Icons.logout,
          iconColor: AppColors.red,
          onTap: () {},
        ),

      ],
    );
  }
}
