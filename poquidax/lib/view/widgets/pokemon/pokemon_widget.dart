import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class PokemonWidget extends StatelessWidget {
  const PokemonWidget({super.key});

  // Method to create each menu item
  Widget _mainMenuItem(BuildContext context, int index, String title, String subtitle) {
    final viewModel = context.watch<PokedexProvider>().viewModel as HomeViewModel;  // Watch the PokedexProvider

    return GestureDetector(
      onTap: () {
        viewModel.setSelectedIndex(index);  // This triggers the update
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          width: double.infinity,
          color: viewModel.selectedIndex == index ? Colors.yellow : Colors.white, // Highlight selection
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokedexProvider>(
      builder: (context, pokedexProvider, child) {
        final screenSize = MediaQuery.of(context).size;;
        
        return Container(
          width: screenSize.width,
          height: screenSize.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _mainMenuItem(context, 0, "Mis Pokémon", "Lista de mis pokémones"),
                _mainMenuItem(context, 1, "Atrapar Pokémon", "Agrega tus Pokémones"),
                _mainMenuItem(context, 2, "Salir", "Volver al inicio de sesión"),
              ],
            ),
          ),
        );
      },
    );
  }
}
