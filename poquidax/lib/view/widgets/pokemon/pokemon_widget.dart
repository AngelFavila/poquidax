import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/view/widgets/pokemon/pokemon_image_loader.dart';
import 'package:pokedax/viewmodel/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';

class PokemonWidget extends StatelessWidget {
  const PokemonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PokedexProvider>(
      builder: (context, pokedexProvider, child) {
        final viewModel = context.watch<PokedexProvider>().viewModel as PokemonViewModel;
        final pokemon = viewModel.pokemon;

        if (pokemon == null) {
          return 
          Expanded(
          child: Container(
            color: Colors.black, 
            child: Center(child: CircularProgressIndicator(color: Colors.white,))
          ),
        );
        }

        return Expanded(
          child: Container(
            color: Colors.black, 
            child: PokemonImageLoader(imageUrl: pokemon.sprite)
          ),
        );
      },
    );
  }
}
