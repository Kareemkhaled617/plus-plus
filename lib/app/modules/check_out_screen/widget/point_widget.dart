import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/app/core/theme/app_fonts.dart';
import 'package:plus/app/core/utils/app_keys.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../../account_screen/controller/account_controller.dart';
import '../controller/check_out_controller.dart';

class UsePointSection extends StatefulWidget {
  const UsePointSection({super.key});

  @override
  State<UsePointSection> createState() => _UsePointSectionState();
}

class _UsePointSectionState extends State<UsePointSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final checkoutController = Get.find<CheckoutController>();
    AccountController controller = Get.find<AccountController>();
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [Color(0xFF7D5DF6), Color(0xFF4A26D7)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [

          GestureDetector(
            onTap: () {
              setState(() => isExpanded = !isExpanded);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              decoration: BoxDecoration(
                // gradient: const LinearGradient(
                //   colors: [Color(0xFF7D5DF6), Color(0xFF4A26D7)],
                // ),
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Use Your Point".tr,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(14)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Insert number of point".tr,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.rewards);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(Assets.iconsStar),
                                width: getProportionateScreenHeight(22),
                                height: getProportionateScreenHeight(22),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              FutureBuilder(
                                  future: controller.fetchPoints(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(controller.points.value.toString(),
                                          style: AppFonts.bodyText.copyWith(
                                            color: AppColors.black,
                                          ));
                                    } else {
                                      return Container();
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Obx(() {
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: checkoutController.point,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '0 Point'.tr,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 60,
                            child: CustomButton(
                              text: AppKeys.apply,
                              isEnabled:
                                  !checkoutController.isLoadingCalculate.value,
                              onPressed: () {
                                if (checkoutController.point.text == '0') {
                                  Get.snackbar(
                                      "Error".tr, "Please enter point".tr);
                                } else {
                                  checkoutController
                                      .calculate(checkoutController.point.text);
                                }
                              },
                            ))
                      ],
                    );
                  }),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
