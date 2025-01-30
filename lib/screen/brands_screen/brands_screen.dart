import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plus/components/custom_text_form_field.dart';
import 'package:plus/screen/brands_screen/widgets/brands_list_item.dart';
import '../../generated/assets.dart';
import '../../utils/app_fonts.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  static final categories = [
    {'title': 'Medicine', 'imageUrl': Assets.tempImg},
    {'title': 'Skin care', 'imageUrl': Assets.tempImg},
    {'title': 'Hair care', 'imageUrl': Assets.tempImg},
    {'title': 'Baby care', 'imageUrl': Assets.tempImg},
    {'title': 'Animals Supplies', 'imageUrl': Assets.tempImg},
    {'title': 'Daily care', 'imageUrl': Assets.tempImg},
    {'title': 'Medicine Supplies', 'imageUrl': Assets.tempImg},
    {'title': 'Animals Supplies', 'imageUrl': Assets.tempImg},
    {'title': 'Daily care', 'imageUrl': Assets.tempImg},
    {'title': 'Medicine Supplies', 'imageUrl': Assets.tempImg},
    {'title': 'Make up', 'imageUrl': Assets.tempImg},
    {'title': 'Make up', 'imageUrl': Assets.tempImg},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Brands".tr,
          style: AppFonts.heading3,
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(Assets.iconsBack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: "Search for the brands".tr,
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              prefixIcon: Image.asset(Assets.iconsSearch),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 1.3,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return BrandsListItem(category: category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
