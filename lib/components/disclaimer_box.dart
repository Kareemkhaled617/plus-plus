import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plus/utils/app_fonts.dart';

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
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(horizontal: 20),

      decoration: BoxDecoration(
        color: Colors.grey[100],
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
                style: AppFonts.bodyText,
                children: [
                  TextSpan(
                    text: highlightedText,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()..onTap = onHighlightTap,
                  ),
                  TextSpan(
                    text: message1,
                    style: AppFonts.bodyText,
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
