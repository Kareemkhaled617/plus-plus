import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/address_directory/address_card.dart';
import 'package:plus/generated/assets.dart';

import '../components/app_bar_back_button.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/app_keys.dart';

class AddressDirectory extends StatelessWidget {
  const AddressDirectory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: AppBarBackButton(),
        backgroundColor: AppColors.white,
        title: Text(
          AppKeys.addressDirectory.tr,
          style: AppFonts.heading3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            SizedBox(
              height: 12,
            ),
            AddressCard(),
            SizedBox(
              height: 12,
            ),
            AddressCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
