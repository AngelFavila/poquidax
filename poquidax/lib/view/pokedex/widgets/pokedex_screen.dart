import 'package:flutter/material.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';

import 'dpad_decorativo.dart';

class PokedexScreen extends StatelessWidget {
  final Size screenSize;
  final Widget screenContent;
  final HomeViewModel viewModel;

  PokedexScreen.pokedexScreen({
    super.key,
    required this.screenContent,
    required this.screenSize,
    required this.viewModel,
  });

@override
Widget build(BuildContext context) {
  return SizedBox(
    width: screenSize.width,
    height: screenSize.height,
    child: Column(
      children: [
        // The top panel containing the CustomPaint and the screen content
        // SizedBox(
        //   width: screenSize.width,
        //   height: screenSize.height * 0.2, // Adjust this height based on your design
        //   child: Stack(
        //     children: [
        //       // Custom painter that draws the border and cutout
        //       CustomPaint(
        //         size: screenSize,
        //         painter: DPadPainter(),
        //       ),
        //       // Panel of the pokedex (screen content)
        //       pokedexPanel(screenContent, screenSize),
        //     ],
        //   ),
        // ),
        // The buttons and control panel section
        Flexible(
          child: Column(
            children: [
              Placeholder(),  // Placeholder can be replaced with your actual widget
              // _buildActionButtons(screenSize),
              // _buildControlPanel(screenSize),
            ],
          ),
        ),
      ],
    ),
  );
}




  // Botones principales del Pokedex
  Widget _buildActionButtons(Size screenSize) {
    print("Building Action Buttons");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {
              if (viewModel.onBackButton == null) {
      print("onBackButton is null");
    } else {
      viewModel.onBackButton();
    }
            },
            child: Text("Atrás")),
        ElevatedButton(onPressed: () {}, child: Text("Aceptar")),
      ],
    );
  }

  // Panel de control adicional
  Widget _buildControlPanel(Size screenSize) {
    return Row(
      children: [
        Container(
          width: screenSize.width * 0.4,
          height: screenSize.width * 0.4,
          color: Colors.green,
          child: Center(
            child: Text(
              "Selecciona una opción del menú para continuar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: screenSize.width * 0.2,
          height: screenSize.width * 0.2,
          color: Colors.black,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ],
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
