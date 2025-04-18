import 'package:flutter/material.dart';
import '../../../../generated/assets.dart';

class LoginLogoWidget extends StatelessWidget {
  const LoginLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesLogo,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
