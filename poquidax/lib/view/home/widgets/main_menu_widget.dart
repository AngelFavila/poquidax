// El widget del cuadro central
  import 'package:flutter/material.dart';

Widget mainMenu(Size screenSize) {
    return Container(
      width: screenSize.width * 0.75,
      height: screenSize.height * 0.4,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _mainMenuItem(
                "Mis Pokémon", "Lista de mis pokémones", Colors.yellow),
            _mainMenuItem(
                "Atrapar Pokémon", "Agrega tus Pokémones", Colors.white),
            _mainMenuItem("Salir", "Volver al inicio de sesión", Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _mainMenuItem(String title, String subtitle, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Flexible(
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
      ),
    );
  }