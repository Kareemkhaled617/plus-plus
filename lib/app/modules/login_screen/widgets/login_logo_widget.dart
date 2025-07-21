import 'package:flutter/material.dart';
import '../../../../generated/assets.dart';

class LoginLogoWidget extends StatelessWidget {
  const LoginLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          Assets.imagesLogo,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
