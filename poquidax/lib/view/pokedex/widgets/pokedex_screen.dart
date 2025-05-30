import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/view/pokedex/painters/cut_corner_painter.dart';
import 'package:provider/provider.dart';

class PokedexScreen extends StatelessWidget {
  final Size screenSize;

  PokedexScreen.pokedexScreen({
    super.key,
    required this.screenSize,
  });

@override
Widget build(BuildContext context) {

  final viewModel = context.watch<PokedexProvider>().viewModel;
  
  return SizedBox(
    width: screenSize.width,
    height: screenSize.height,
    child: Column(
      children: [
        // The top panel containing the CustomPaint and the screen content
        SizedBox(
          width: screenSize.width,
          height: screenSize.height, // Adjust this height based on your design
          child: Stack(
            children: [
              // Custom painter that draws the border and cutout
              CustomPaint(
                size: screenSize,
                painter: CutCornerPainter(),
              ),
              // Panel of the pokedex (screen content)
              pokedexPanel(viewModel.screenContent, screenSize),
            ],
          ),
        ),
      ],
    ),
  );
}

}

/*
El panel de la pantalla del Pokedex donde se mostraran los diferentes widgets dependiendo de la funcionalidad.
*/
Widget pokedexPanel(Widget screenContent, Size size) {
  return Container(
    width: size.width,
    height: size.height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(size.width),
    ),
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
