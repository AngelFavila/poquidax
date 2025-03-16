import 'package:flutter/material.dart';
import 'package:pokedax/viewmodel/main_viewModel.dart';

import '../../viewmodel/home_viewModel.dart';

class HomeView extends StatelessWidget {
  final Widget screenContent;
  HomeViewModel _viewModel;
  final Size screenSize;

  HomeView(this._viewModel, {super.key, required this.screenSize, required Function onBackButton, required this.screenContent}) {
    _viewModel.onBackButton = onBackButton; 
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double sidePadding = constraints.maxWidth * 0.15;
          double topPadding = constraints.maxHeight * 0.05; // Subtract top padding

          return SizedBox(
            child: Padding(
              padding: EdgeInsets.only(
                left: sidePadding,
                top: topPadding,
                right: sidePadding,
              ),
              child: PokeScreenFrame.pokedexScreenFrame(
                screenContent: screenContent,
                screenSize: Size(screenSize.width, screenSize.height * 0.4), viewModel: _viewModel,
              ),
            ),
          );
        },
      ),
    );
  }
}

class PokeScreenFrame extends StatelessWidget {
  final Size screenSize;
  final Widget screenContent;
  final HomeViewModel viewModel;

  PokeScreenFrame.pokedexScreenFrame({
    super.key,
    required this.screenContent,
    required this.screenSize , required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: Column(
        children: [Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomPaint(
            size: screenSize,
            painter: CutCornerPainter(),
          ),
          pokedexScreen(screenContent,screenSize)
        ],
      ),
        ElevatedButton(onPressed: () => viewModel.onBackButton(), child: Text('Back'))
        ]
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

    canvas.drawCircle(Offset(size.width / 2 - radius * 2, radius * 4), radius, circlePaint);
    canvas.drawCircle(Offset(size.width / 2 + radius * 2, radius * 4), radius, circlePaint);
    canvas.drawCircle(Offset(size.width * 0.16 - radius * 2, size.height * 0.85), radius, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget pokedexScreen(Widget screenContent, Size size) {
  return SizedBox(
    width: size.width,
    height: size.height,
    child: Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.10,
        top: size.height * 0.15,
        right: size.width * 0.10,
        bottom: size.height * 0.21, 
      ),
      child: screenContent,
    ),
  );
}
