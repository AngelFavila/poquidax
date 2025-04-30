import 'package:flutter/material.dart';
import 'package:pokedax/viewmodel/catch_viewmodel.dart';

class CatchFormView extends StatefulWidget {
  final Size screenSize;
  final CatchViewModel viewModel; // Add the ViewModel as a parameter

  CatchFormView ({required this.screenSize, required this.viewModel});

  @override
  _CatchFormViewState createState() => _CatchFormViewState();
}

class _CatchFormViewState extends State<CatchFormView > {
  @override
  void initState() {
    super.initState();
  }

  // Widget to build each menu item
  Widget _mainMenuItem(int index, String title, String subtitle) {
    return Placeholder();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenSize.width,
      height: widget.screenSize.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _mainMenuItem(0, "Mis Pokémon", "Lista de mis pokémones"),
            _mainMenuItem(1, "Atrapar Pokémon", "Agrega tus Pokémones"),
            _mainMenuItem(2, "Salir", "Volver al inicio de sesión"),
          ],
        ),
      ),
    );
  }
}