import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_template.dart';
import 'package:provider/provider.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  @override
  Widget build(BuildContext context) {
    print("PokedexView build called");
    return Consumer<PokedexProvider>(
      builder: (context, pokedexProvider, child) {
        return PokedexTemplate(
          screenSize: pokedexProvider.screenSize,
        );
      },
    );
  }
}