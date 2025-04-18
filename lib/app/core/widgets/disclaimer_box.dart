import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plus/app/core/utils/size_config.dart';

import '../theme/app_colors.dart';
import '../theme/app_fonts.dart';

class DisclaimerBox extends StatelessWidget {
  final String message;
  final String message1;
  final String highlightedText;
  final VoidCallback onHighlightTap;

  const DisclaimerBox({
    required this.message,
    required this.message1,
    required this.highlightedText,
    required this.onHighlightTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.categoryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: message,
                style: AppFonts.bodyText
                    .copyWith(fontSize: getResponsiveFontSize(12), height: 1.6),
                children: [
                  TextSpan(
                    text: highlightedText,
                    style: TextStyle(
                        height: 1.6,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: getResponsiveFontSize(12)),
                    recognizer: TapGestureRecognizer()..onTap = onHighlightTap,
                  ),
                  TextSpan(
                    text: message1,
                    style: AppFonts.bodyText.copyWith(
                      fontSize: getResponsiveFontSize(12),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
              textScaler: TextScaler.linear(1.1),
            ),
          ),
        ],
      ),
    );
  }
}
