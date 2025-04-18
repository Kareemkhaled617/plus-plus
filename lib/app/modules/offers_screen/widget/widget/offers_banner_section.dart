import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/widgets/brands_list_item.dart';
import 'package:plus/app/core/widgets/loader.dart';

import '../../../../../generated/assets.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_fonts.dart';
import '../../../../core/utils/app_keys.dart';
import '../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../routes/app_routes.dart';
import '../../../view_offers_screen/view_offers_screen.dart';
import '../../controller/offer_controller.dart';
import 'offer_image_widget.dart';

class OffersBannerSection extends StatelessWidget {
  const OffersBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final OfferController controller = Get.find<OfferController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: AppLoader());
      } else if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      } else if (controller.offers.isEmpty) {
        return Center(child: Text('No offers available.'.tr));
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ...List.generate(
            //   controller.offers.length,
            //   (index) => Expanded(
            //       child: OfferImageWidget(
            //     isCenter: controller.offers[index].offerId == 2,
            //     onTap: () {
            //       controller
            //           .fetchBrandsByOffer(controller.offers[index].offerId);
            //       showCustomBottomSheet(context, Obx(() {
            //         if (controller.isLoadingBrand.value) {
            //           return Center(child: AppLoader());
            //         } else if (controller.errorMessage.isNotEmpty) {
            //           return Center(child: Text(controller.errorMessage.value));
            //         } else if (controller.brands.isEmpty) {
            //           return buildEmptyBottomSheetOffers(context);
            //         } else {
            //           return buildBottomSheetOffers(
            //               context,
            //               controller,
            //               controller.offers[index].offerId,
            //               controller.offers[index].image!);
            //         }
            //       }));
            //     },
            //     image: controller.offers[index].image ?? '',
            //   )),
            // ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: OfferImageWidget(
                isCenter: controller.offers[0].offerId == 2,
                onTap: () {
                  controller.fetchBrandsByOffer(controller.offers[0].offerId);
                  showCustomBottomSheet(context, Obx(() {
                    if (controller.isLoadingBrand.value) {
                      return Center(child: AppLoader());
                    } else if (controller.errorMessage.isNotEmpty) {
                      return Center(child: Text(controller.errorMessage.value));
                    } else if (controller.brands.isEmpty) {
                      return buildEmptyBottomSheetOffers(context);
                    } else {
                      return buildBottomSheetOffers(
                          context,
                          controller,
                          controller.offers[0].offerId,
                          controller.offers[0].image!);
                    }
                  }));
                },
                image: controller.offers[0].image ?? '',
              ),
            )),
            Expanded(
                child: OfferImageWidget(
              isCenter: controller.offers[1].offerId == 2,
              onTap: () {
                controller.fetchBrandsByOffer(controller.offers[1].offerId);
                showCustomBottomSheet(context, Obx(() {
                  if (controller.isLoadingBrand.value) {
                    return Center(child: AppLoader());
                  } else if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  } else if (controller.brands.isEmpty) {
                    return buildEmptyBottomSheetOffers(context);
                  } else {
                    return buildBottomSheetOffers(
                        context,
                        controller,
                        controller.offers[1].offerId,
                        controller.offers[1].image!);
                  }
                }));
              },
              image: controller.offers[1].image ?? '',
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: OfferImageWidget(
                isCenter: controller.offers[2].offerId == 2,
                onTap: () {
                  controller.fetchBrandsByOffer(controller.offers[2].offerId);
                  showCustomBottomSheet(context, Obx(() {
                    if (controller.isLoadingBrand.value) {
                      return Center(child: AppLoader());
                    } else if (controller.errorMessage.isNotEmpty) {
                      return Center(child: Text(controller.errorMessage.value));
                    } else if (controller.brands.isEmpty) {
                      return buildEmptyBottomSheetOffers(context);
                    } else {
                      return buildBottomSheetOffers(
                          context,
                          controller,
                          controller.offers[2].offerId,
                          controller.offers[2].image!);
                    }
                  }));
                },
                image: controller.offers[2].image ?? '',
              ),
            ))
          ],
        );
      }
    });
  }

  Widget buildBottomSheetOffers(
    context,
    OfferController controller,
    int offerId,
    String image,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppKeys.selectOffers.tr,
              style: AppFonts.bodyText.copyWith(fontWeight: FontWeight.w700),
            ),
            Spacer(),
            InkWell(
              onTap: () => Get.back(),
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
            ...List.generate(
              controller.brands.length,
              (index) => BrandsListItem(
                brand: controller.brands[index],
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.viewOffers, arguments: {
                    'offerId': offerId,
                    'brandId': controller.brands[index].id,
                    'imageUrl': image,
                  });
                },
              ),
            )
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
