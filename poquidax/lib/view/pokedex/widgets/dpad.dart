import 'package:flutter/material.dart';

class DPad extends StatelessWidget {
  final void Function(String direction) onPressed;
  final double size;
  
  const DPad({required this.onPressed, Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background painter
          CustomPaint(
            size: Size(size, size),
            painter: DPadPainter(),
          ),
          Align(
            alignment: FractionalOffset(0.5, -0.05), // Up
            child: _buildDPadButton("Up", Icons.arrow_drop_up),
          ),
          Align(
            alignment: FractionalOffset(0.5, 1.05), // Down
            child: _buildDPadButton("Down", Icons.arrow_drop_down),
          ),
          Align(
            alignment: FractionalOffset(-0.05, 0.5), // Left
            child: _buildDPadButton("Left", Icons.arrow_left),
          ),
          Align(
            alignment: FractionalOffset(1.05, 0.5), // Right
            child: _buildDPadButton("Right", Icons.arrow_right),
          ),
        ],
      ),
    );
  }

  Widget _buildDPadButton(String direction, IconData icon) {
    return GestureDetector(
      onTap: () => onPressed(direction),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Icon(icon, color: Colors.grey.shade900),
      ),
    );
  }
}

class DPadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Path path = Path();

    double centerX = size.width / 2;
    double centerY = size.width / 2;
    double buttonSize = size.width*0.17;

    path.addRect(Rect.fromLTWH(centerX - buttonSize, 0, buttonSize * 2, size.height));
    path.addRect(Rect.fromLTWH(0, centerY - buttonSize, size.width, buttonSize * 2));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
