import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:plus/app/core/widgets/app_bar_back_button.dart';
import 'package:plus/app/core/widgets/custom_button.dart';
import 'package:plus/generated/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/app_keys.dart';
import '../../core/widgets/custom_text_form_field.dart';


class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: AppBarBackButton(),
        backgroundColor: AppColors.white,
        title: Text(
          AppKeys.account.tr,
          style: AppFonts.heading3,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppKeys.fullName.tr,
                  style: AppFonts.heading3.copyWith(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  hintText: "Abdelaziz.Ahmed",
                  suffixIcon: Image.asset(Assets.iconsEdit),
                ),
                SizedBox(
                  height: 21,
                ),
                Text(
                  AppKeys.phoneNumber.tr,
                  style: AppFonts.heading3.copyWith(
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                IntlPhoneField(
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: Image.asset(
                      Assets.iconsEdit,
                      width: 12,
                      height: 12,
                    ),
                    fillColor: Colors.blue.shade50.withOpacity(.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  initialCountryCode: 'EG',
                  onChanged: (phone) {
                    log(phone.completeNumber);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    text: AppKeys.save.tr,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )),
    );
  }
}
