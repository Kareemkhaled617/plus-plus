import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../../core/theme/app_fonts.dart';



class ProductBrandItem extends StatelessWidget {
  const ProductBrandItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: Image.asset(Assets.tempCream, fit: BoxFit.contain),
      ),
      title: Text("La ROCHE-POSAY", style: AppFonts.heading3.copyWith(fontSize: 14)),
    );
  }
}
