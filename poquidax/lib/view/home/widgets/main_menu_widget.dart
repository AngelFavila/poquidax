import 'package:flutter/material.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';

class MainMenu extends StatefulWidget {
  final Size screenSize;
  final HomeViewModel viewModel; // Add the ViewModel as a parameter

  MainMenu({required this.screenSize, required this.viewModel});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
  }

  // Widget to build each menu item
  Widget _mainMenuItem(int index, String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.viewModel.setSelectedIndex(index); // Update the ViewModel
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          width: double.infinity,
          color: widget.viewModel.selectedIndex == index ? Colors.yellow : Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
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