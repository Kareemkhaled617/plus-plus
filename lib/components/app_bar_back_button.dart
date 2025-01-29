import 'package:flutter/material.dart';

import '../generated/assets.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Image.asset(Assets.iconsBack),
    );
  }
}
