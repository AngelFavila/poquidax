import 'package:flutter/material.dart';

Widget BannerContainer({required double height,required ColorScheme colorScheme}) {
  return SizedBox(
                  height: height,
                  child: 
                LayoutBuilder(
    builder: (context, constraints) {
      return PokedexBanner(
        colorScheme: colorScheme,
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      );
    },
  ));
}

class PokedexBanner extends StatelessWidget {
  final double width;
  final double height;
  final ColorScheme colorScheme;

  const PokedexBanner({super.key, this.width = 100, this.height = 100, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: BannerPainter(colorScheme: colorScheme),
          ),
          // const Text('Texto de prueba'),
        ],
      ),
    );
  }
}

class BannerPainter extends CustomPainter {
  final ColorScheme colorScheme;
  const BannerPainter({required this.colorScheme});
  
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = colorScheme.error // Stroke color
      ..style = PaintingStyle.stroke  // Stroke style
      ..strokeWidth = 3.0;

    Path path = Path();
    path.moveTo(0, size.height );
    path.lineTo(size.width * 0.4, size.height );
    path.lineTo(size.width * 0.6, size.height *0.6);
    path.lineTo(size.width, size.height * 0.6);

    canvas.drawPath(path, paint);

    paint.strokeWidth = 4.0;
    path = Path();
    path.moveTo(0, size.height*0.95 );
    path.lineTo(size.width * 0.39, size.height *0.95);
    path.lineTo(size.width * 0.59, size.height *0.55);
    path.lineTo(size.width, size.height * 0.55);

    canvas.drawPath(path, paint);

    // Big light
    var circlePaint = Paint()
      ..color = Colors.white 
      ..style = PaintingStyle.fill;

    double radius = size.height * 0.35; //White background
    canvas.drawCircle(Offset(size.width/7, size.height*.5), radius, circlePaint);

    circlePaint.color = Color(0xFF2CAEF6); // Outer light
    radius = size.height * 0.3; 
    canvas.drawCircle(Offset(size.width/7, size.height*0.5), radius, circlePaint);

    circlePaint.color = Color(0xFF1C689C); 
    radius = size.height * 0.22; // Light shadow
    canvas.drawCircle(Offset(size.width/6.5, size.height*0.53), radius, circlePaint);

    circlePaint.color = Color(0xFFA3DBFC); 
    radius = size.height * 0.12; // sparkle
    canvas.drawCircle(Offset(size.width/8.5, size.height*0.4), radius, circlePaint); 


    // Small lights
    double littleLightRadius = size.width * 0.03; 
    var redOffset = Offset(size.width*0.3, size.height*.4);
    AddCircleToCanvas(canvas, littleLightRadius, redOffset, Color(0xFFFF0000)); 

    // Yellow
    var yellowOffset = Offset(size.width*0.38, size.height*.4);
    AddCircleToCanvas(canvas, littleLightRadius, yellowOffset, Color(0xFFFFFF00)); 
    // Green light
    var greenOffset = Offset(size.width*0.46, size.height*.4);
    AddCircleToCanvas(canvas, littleLightRadius, greenOffset, Color(0xFF11FF00));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void AddCircleToCanvas(Canvas canvas,double radius, Offset offset,Color color){
    var circlePaint = Paint()
      ..color = Colors.white 
      ..style = PaintingStyle.fill;
      // Green
      circlePaint.color = color; 
      radius = radius; 
      canvas.drawCircle(offset, radius, circlePaint);
  }
}
