import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double dashWidth = 5;
    double dashSpace = 5;
    double startX = 0;
    double startY = 0;

    // Draw the top border
    for (startX = 0; startX < size.width; startX += dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
    }

    // Draw the right border
    for (startY = 0; startY < size.height; startY += dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, startY + dashWidth),
        paint,
      );
    }

    // Draw the bottom border
    for (startX = size.width; startX > 0; startX -= dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(startX, size.height),
        Offset(startX - dashWidth, size.height),
        paint,
      );
    }

    // Draw the left border
    for (startY = size.height; startY > 0; startY -= dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY - dashWidth),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
