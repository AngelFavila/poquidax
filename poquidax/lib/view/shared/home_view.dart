import 'package:flutter/material.dart';
import '../../viewmodel/home_viewModel.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  final Widget screenContent;
  final HomeViewModel _viewModel;
  final Size screenSize;

  HomeView(
    this._viewModel, {
    super.key,
    required this.screenSize,
    required Function onBackButton,
    required this.screenContent,
  }) {
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
                  PokeScreenFrame.pokedexScreenFrame(
                    screenContent: screenContent, // Comprobamos que no sea null
                    screenSize: Size(screenSize.width, screenSize.height * 0.4),
                    viewModel: _viewModel,
                  ),
                  _buildCentralBox(screenSize),
                  _buildActionButtons(screenSize),
                  _buildControlPanel(screenSize),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // El widget del cuadro central
  Widget _buildCentralBox(Size screenSize) {
    return Container(
      width: screenSize.width * 0.8,
      height: screenSize.height * 0.4,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMenuItem(
              "Mis Pokémon", "Lista de mis pokémones", Colors.yellow),
          _buildMenuItem(
              "Atrapar Pokémon", "Agrega tus Pokémones", Colors.white),
          _buildMenuItem("Salir", "Volver al inicio de sesión", Colors.white),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, String subtitle, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        color: bgColor,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // Los botones de acción
  Widget _buildActionButtons(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {}, child: Text("Atrás")),
        ElevatedButton(onPressed: () {}, child: Text("Aceptar")),
      ],
    );
  }

  // Panel de control adicional
  Widget _buildControlPanel(Size screenSize) {
    return Column(
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

class PokeScreenFrame {
  static pokedexScreenFrame({
    required Widget screenContent,
    required Size screenSize,
    required HomeViewModel viewModel,
  }) {}
}
