import 'package:flutter/material.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';
import '../generated/assets.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextFormField({
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.validator,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.hintText,
        filled: true,
        fillColor: AppColors.lightLavender,
        prefixIcon: Image.asset(Assets.iconsSearch),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
      ),
      validator: validator,
    );
  }
}
