import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/viewmodel/catch_viewmodel.dart';
import 'package:provider/provider.dart';

class CatchFormView extends StatefulWidget { 

  CatchFormView ();

  @override
  _CatchFormViewState createState() => _CatchFormViewState();
}

class _CatchFormViewState extends State<CatchFormView > {
  @override
  void initState() {
    super.initState();
  }

  Widget _mainMenuItem(int index, String title, String subtitle) {
    return Placeholder();
  }
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final viewModel = context.watch<PokedexProvider>().viewModel as CatchViewModel;
    
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Pokemon number: '+viewModel.selectedPokemonNumber.toString()),
            _mainMenuItem(0, "Mis Pokémon", "Lista de mis pokémones"),
            _mainMenuItem(1, "Atrapar Pokémon", "Agrega tus Pokémones"),
            _mainMenuItem(2, "Salir", "Volver al inicio de sesión"),
          ],
        ),
      ),
    );
  }
}