import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/brands_list_item.dart';

import '../../../../../generated/assets.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/utils/app_keys.dart';
import '../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../routes/app_routes.dart';
import '../../../view_offers_screen/view_offers_screen.dart';
import 'offer_image_widget.dart';

class OffersBannerSection extends StatelessWidget {
  const OffersBannerSection({super.key});

  static final categories = [
    {'title': 'Medicine', 'imageUrl': Assets.tempImg},
    {'title': 'Skin care', 'imageUrl': Assets.tempImg},
    {'title': 'Hair care', 'imageUrl': Assets.tempImg},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: OfferImageWidget(
          onTap: () {
            showCustomBottomSheet(
              context,
              buildEmptyBottomSheetOffers(context),
            );
          },
        )),
        Expanded(
          child: OfferImageWidget(
            isCenter: true,
            onTap: () {
              showCustomBottomSheet(
                context,
                buildBottomSheetOffers(context),
              );
            },
            image: Assets.tempOffers2,
          ),
        ),
        Expanded(child: OfferImageWidget(
          onTap: () {
            showCustomBottomSheet(
              context,
              buildEmptyBottomSheetOffers(context),
            );
          },
        )),
      ],
    );
  }

  Widget buildBottomSheetOffers(context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppKeys.selectOffers.tr,
              style: AppFonts.bodyText,
            ),
            Spacer(),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.grey.withOpacity(.1),
                child: Icon(
                  Icons.close,
                  color: AppColors.red,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 12),
        GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1,
          ),
          children: [
            BrandsListItem(
              category: categories[0],
              onTap: () {
                Get.toNamed(AppRoutes.viewOffersScreen);
              },
            ),
            BrandsListItem(
              category: categories[0],
              onTap: () {},
            ),
            BrandsListItem(
              category: categories[0],
              onTap: () {},
            ),
            BrandsListItem(
              category: categories[0],
              onTap: () {},
            ),
            BrandsListItem(
              category: categories[0],
              onTap: () {},
            ),
            BrandsListItem(
              category: categories[0],
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget buildEmptyBottomSheetOffers(context) {
    return Column(
      children: [
        Image.asset(
          Assets.iconsNoOffers,
          width: 50,
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          AppKeys.noOffersAtMoment.tr,
          style: AppFonts.bodyText.copyWith(
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(horizontal: 15),
            minimumSize: Size(180, 43),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: Text(
            AppKeys.returnText.tr,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        )
      ],
    );
  }
}
