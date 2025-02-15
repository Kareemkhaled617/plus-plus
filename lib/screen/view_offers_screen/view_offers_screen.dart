import 'package:flutter/material.dart';
import 'package:plus/generated/assets.dart';
import 'package:plus/screen/home_screen/widgets/products_grid.dart';
import 'package:plus/screen/view_offers_screen/widget/brands_dropdown.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';

class ViewOffersScreen extends StatelessWidget {
  const ViewOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.babyBlue.withOpacity(.5),
                  ),
                  child: Column(
                    children: [
                      Image.asset(Assets.tempLargeBanner),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            color: AppColors.deepRed,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              "Through two hours, Dont miss the chance !",
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Image.asset(Assets.iconsOffersPercent, height: 20),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              "Buy one product and you will get the second one free",
                              style: AppFonts.bodyText.copyWith(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: BrandsDropdown(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .6,
                child: ProductsGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
