import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:plus/generated/assets.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../core/widgets/app_bar_back_button.dart';

import 'address_card.dart';

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
