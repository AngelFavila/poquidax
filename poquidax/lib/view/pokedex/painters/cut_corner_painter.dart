import 'package:flutter/material.dart';

class CutCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFDEDEDE) // Background color
      ..style = PaintingStyle.fill;

    var path = Path();
    double cutSize = size.width * 0.15;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(cutSize, size.height);
    path.lineTo(0, size.height - cutSize);
    path.close();

    canvas.drawPath(path, paint);

    var circlePaint = Paint()
      ..color = Color(0xFFDB082D) // Circle color
      ..style = PaintingStyle.fill;

    double radius = size.width * 0.02;

    canvas.drawCircle(
      Offset(size.width / 2 - radius * 2, radius * 4),
      radius,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width / 2 + radius * 2, radius * 4),
      radius,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.16 - radius * 2, size.height * 0.85),
      radius,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
