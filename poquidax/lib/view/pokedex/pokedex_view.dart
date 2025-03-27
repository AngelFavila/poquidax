import 'package:flutter/material.dart';
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
