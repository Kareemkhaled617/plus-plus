import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/utils/app_keys.dart';
import 'package:plus/app/modules/home_screen/widgets/category_page.dart';
import 'package:plus/app/modules/home_screen/widgets/circular_image_slider.dart';
import 'package:plus/app/modules/home_screen/widgets/contact_us.dart';
import 'package:plus/app/modules/home_screen/widgets/prescription.dart';
import 'package:plus/app/modules/home_screen/widgets/section_header.dart';
import 'package:plus/app/modules/home_screen/widgets/section_page.dart';

import '../../../generated/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/utils/size_config.dart';
import '../account_screen/controller/business_settings_controller.dart';
import 'arrival_timer/presentation/widgets/arrival_timer_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BusinessSettingsController businessSettingsController =
        Get.find<BusinessSettingsController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SectionHeader(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(46),
                            topRight: Radius.circular(46)),
                        color: AppColors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CircularImageSlider(),
                          SizedBox(
                            height: 20,
                          ),
                          ArrivalTimerCard(),

                          // SizedBox(
                          //   height: 10,
                          // ),
                          // DisclaimerBox(
                          //   message: AppKeys.pharmacyPartnerInfo.tr,
                          //   highlightedText: ' El Lewaa Elteby  ',
                          //   onHighlightTap: () {},
                          //   message1:
                          //       "Pharmacy and under its full medical supervision."
                          //           .tr,
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              AppKeys.categories.tr,
                              textAlign: TextAlign.start,
                              style: AppFonts.heading1.copyWith(
                                  fontSize: getResponsiveFontSize(19),
                                 color: AppColors.primary,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CategoryPage(),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              AppKeys.addYourPrescription.tr,
                              textAlign: TextAlign.start,
                              style: AppFonts.heading1.copyWith(
                                  fontSize: getResponsiveFontSize(17),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Prescription(),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              AppKeys.pOffers.tr,
                              textAlign: TextAlign.start,
                              style: AppFonts.heading1.copyWith(
                                  fontSize: getResponsiveFontSize(17),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          CircularImageSlider1(),
                          SizedBox(height: 16),
                          SectionPage(),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: businessSettingsController.isLoading.value
                    ? null
                    : () {
                        showContactDialog(
                            context,
                            businessSettingsController
                                .settings.value!.phoneNumber,
                            businessSettingsController.settings.value!.address);
                      },
                child: Container(
                  width: 128,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        // Soft shadow
                        blurRadius: 13,
                        // Smooth blur effect
                        offset: Offset(8, 16),
                        // Moves shadow slightly down and right
                        spreadRadius: 2, // Optional: Makes shadow larger
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        AppKeys.contactUs.tr,
                        style: AppFonts.bodyText.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10),
                      Image(
                        image: AssetImage(Assets.iconsWhatsapp),
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   backgroundColor: AppColors.white,
        //   onPressed: () {},
        //   label: Row(
        //     children: [
        //       Text(
        //         AppKeys.contactUs.tr,
        //         style: AppFonts.bodyText
        //             .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Image(
        //         image: AssetImage(Assets.iconsWhatsapp),
        //         width: 50,
        //         height: 50,
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
