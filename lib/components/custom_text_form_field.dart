import 'package:flutter/material.dart';
import 'package:plus/utils/app_colors.dart';
import 'package:plus/utils/app_fonts.dart';
import '../generated/assets.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool isMaxLines;
  final Color? fillColor;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;

  const CustomTextFormField({
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    super.key,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.focusNode,
    this.onChanged,
    this.isMaxLines = false,
    this.fillColor,
    this.prefixIcon,
    this.hintStyle,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode,
      onChanged: onChanged,
      maxLines: isMaxLines ? 4 : 1,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? AppFonts.hintText,
        filled: true,
        suffixIcon: suffixIcon,
        fillColor: fillColor ?? AppColors.categoryBackground,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
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
