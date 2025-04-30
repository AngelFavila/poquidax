import 'package:flutter/material.dart';

class DPadDecorativo extends StatelessWidget {
  const DPadDecorativo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.black,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 30,
              height: 70,
              color: Colors.black,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 70,
              height: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class DPadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFDEDEDE)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.3, size.height);
    path.lineTo(0, size.height * 0.7);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
