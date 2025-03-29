import 'package:flutter/material.dart';
import 'package:pokedax/view/pokedex/widgets/dpad.dart';
import '../../viewmodel/home_viewmodel.dart';
import 'widgets/pokedex_screen.dart';

// ignore: must_be_immutable
// View del pokedex reutilizado en múltiples páginas
class PokedexView extends StatelessWidget {
  // Widget que contiene el contenido mostrado en la pantalla del Pokedeex
  final Widget screenContent;
  // ViewModel que modifica el comportamiento de la pantalla
  final HomeViewModel _viewModel;
  // Tamaño de la pantalla para cálculos de porcentajes de elementos
  final Size screenSize;

  PokedexView(
    this._viewModel, {
    super.key,
    required this.screenSize,
    required this.screenContent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double sidePadding = constraints.maxWidth * 0.15;
          double topPadding = constraints.maxHeight * 0.05;

          return SizedBox(
            child: Padding(
              padding: EdgeInsets.only(
                left: sidePadding,
                top: topPadding,
                right: sidePadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Contenido de la pantalla
                  PokedexScreen.pokedexScreen(
                    // Contenido dinámico
                    screenContent: screenContent,
                    screenSize: Size(screenSize.width, screenSize.height * 0.4),
                    // Se asigna el viewModel dinámico al PokedexScreen
                    viewModel: _viewModel,
                  ),
                  Expanded(
                      child: Container(
                    child: Column(children: [
                      _buildActionButtons(screenSize),
                      _buildControlPanel(screenSize)
                    ]),
                  ))
                ],
              ),
            ),
          );
        },
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
              _viewModel.onBackButton();
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
        Padding(
          padding: EdgeInsets.only(right: screenSize.width * 0.05),
          child: Container(
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
        ),
        SizedBox(height: 10),
        DPad(
          size : screenSize.width*.25,
          onPressed: (direction) {
            print("Pressed: $direction");
          },
        ),
      ],
    );
  }
}
