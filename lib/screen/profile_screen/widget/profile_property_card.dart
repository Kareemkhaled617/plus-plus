import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class ProfilePropertyCard extends StatelessWidget {
  const ProfilePropertyCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.black,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 3,
      ),
      ListTile(

        title: Text(
          title,
          style: AppFonts.heading3.copyWith(fontSize: 14),
        ),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle!,
                style: AppFonts.bodyText.copyWith(
                  fontSize: 12,
                  color: AppColors.greyWithShade.withOpacity(.5),
                ),
              ),
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios,
              color: iconColor,
              size: 20,
            )),
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: iconColor),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
      Divider(
        thickness: .5,
        color: AppColors.greyWithShade.withOpacity(.2),
      ),
    ]);
  }
}
