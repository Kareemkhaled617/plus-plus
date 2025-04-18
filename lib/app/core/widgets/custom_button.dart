import 'package:flutter/material.dart';
import 'package:plus/app/core/widgets/loader.dart';

import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final Size? miniSize;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    super.key,
    this.miniSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        minimumSize: miniSize ?? Size(220, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: isEnabled ? AppColors.primary : Colors.grey,
        textStyle: TextStyle(
          fontSize: 16,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
      ),
      child: isEnabled
          ? Text(
              text,
              style: AppFonts.bodyText.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.white),
            )
          : SizedBox(
              height: 30,
              child: AppLoader(),
            ),
    );
  }
}
