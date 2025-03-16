import 'package:flutter/material.dart';

SizedBox pokeScreenFrameContainer(Widget screenContent,double width, double height) {
  return SizedBox(
              height: height,
              width: width,
              child: LayoutBuilder(
    builder: (context, constraints) {
      double sidePadding = constraints.maxWidth * 0.15;
      double topPadding = constraints.maxHeight*0.05; // Subtract top padding
      return SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: sidePadding, top: topPadding, right: sidePadding),
          child: PokeScreenFrame.pokedexScreenFrame(screenContent: screenContent, width: width, height: height,),
        ),
      );
    },
  ));
}

class PokeScreenFrame extends StatelessWidget {
  final double width;
  final double height;
  final Widget screenContent;

  const PokeScreenFrame.pokedexScreenFrame({super.key, required this.screenContent, this.width = 100, this.height = 100});

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
            painter: CutCornerPainter(),
          ),
          pokedexScreen(screenContent,height*0.4),
        ],
      ),
    );
  }
}

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

    canvas.drawCircle(Offset(size.width/2-radius*2, radius*4), radius, circlePaint);
    canvas.drawCircle(Offset(size.width/2+radius*2, radius*4), radius, circlePaint);
    canvas.drawCircle(Offset(size.width*0.16-radius*2, size.height*0.85), radius, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

LayoutBuilder pokedexScreen(Widget screenContent, double height) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double leftPadding = constraints.maxWidth * 0.10;
      double topPadding = constraints.maxHeight * 0.15;
      return SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Padding(
          padding: EdgeInsets.only(
              left: leftPadding,
              top: topPadding,
              right: leftPadding,
              bottom: topPadding *1.4),
          child: SizedBox(
            height: height,
            child: screenContent)
        ),
      );
    },
  );
}
