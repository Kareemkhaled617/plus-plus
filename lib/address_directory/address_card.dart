import 'package:flutter/material.dart';

import '../generated/assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {

      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.babyBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(
            "Home",
            style: AppFonts.heading3,
          ),
          subtitle: Text(
            "Cairo ,El-Gash street build 4 ",
            style: AppFonts.bodyText.copyWith(
              fontSize: 14,
            ),
          ),
          trailing: Image.asset(Assets.iconsEdit),
          leading:  InkWell(
            onTap: () {},
            child: Icon(
              Icons.home_outlined,
              color: AppColors.primary,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
