import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../domain/entities/address_entity.dart';
import '../../routes/app_routes.dart';

class AddressCard extends StatelessWidget {
  final AddressEntity address;

  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.babyBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(address.setAs,
            style: AppFonts.heading2
                .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
        subtitle: Text(
          address.address,
          style: AppFonts.bodyText.copyWith(fontSize: 14),
        ),
        trailing: InkWell(
            onTap: () {
              print('====================================');
              print(address.lat);
              print(address.lng);
              // Get.toNamed(AppRoutes.accessLocationScreen,
              //     arguments: {'edit': true, 'address': address});
              Get.toNamed(
                AppRoutes.accessLocationScreen,
                arguments: {
                  'edit': true,
                  'address': {
                    'lat': address.lat,
                    'lng': address.lng,
                  },
                },
              );
            },
            child: Icon(Icons.edit, color: AppColors.primary)),
        leading: Icon(Icons.home_outlined, color: AppColors.primary, size: 32),
      ),
    );
  }
}
