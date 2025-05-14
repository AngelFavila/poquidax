import 'package:flutter/material.dart';

class DPad extends StatelessWidget {
  final Function onUpPressed;
  final Function onDownPressed;
  final Function onLeftPressed;
  final Function onRightPressed;
  final double size;
  
  const DPad({ Key? key, required this.size, required this.onUpPressed, required this.onDownPressed, required this.onLeftPressed, required this.onRightPressed}) : super(key: key);

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
      onTap: () => {
        if(direction == "Up") { onUpPressed()}
        else if(direction == "Down") { onDownPressed()}
        else if(direction == "Left") { onLeftPressed() }
        else if(direction == "Right") { onRightPressed() },
      },
      child: Container(
        width: size * 0.35,
        height: size * 0.35,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.transparent,
        ),
        child: Icon(icon, color: Colors.grey.shade700),
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
    double buttonSize = size.width * 0.17;
    double borderRadius = 11.0; 

    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(centerX - buttonSize, 0, buttonSize * 2, size.height),
      Radius.circular(borderRadius),
    ));

    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, centerY - buttonSize, size.width, buttonSize * 2),
      Radius.circular(borderRadius),
    ));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
