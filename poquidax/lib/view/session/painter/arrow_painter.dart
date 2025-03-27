import 'dart:ui';

import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // Draw a yellow arrow at the top-left corner
    final arrowPath = Path()
      ..moveTo(size.width * .05, size.height / 2)
      ..lineTo(size.width * .1, size.height / 2 - size.height * 0.03)
      ..lineTo(size.width * .1, size.height / 2 + size.height * 0.03)
      ..close();

    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
