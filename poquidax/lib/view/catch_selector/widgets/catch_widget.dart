import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';
import 'package:pokedax/viewmodel/catch_viewmodel.dart';
import 'package:provider/provider.dart';

class CatchWidget extends StatefulWidget {// Add the ViewModel as a parameter

  CatchWidget();

  @override
  _CatchState createState() => _CatchState();
}

class _CatchState extends State<CatchWidget> {
  final controller = TextEditingController(); // Controller for the search bar
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokedexProvider>().viewModel as CatchSelectorViewModel;
    final screenSize = context.watch<PokedexProvider>().screenSize;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: Colors.white,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: SearchBarWidget()),
          Expanded(
              child: ListView.builder(
            itemCount: viewModel.filteredPokemons.length,
            itemBuilder: (context, index) {
              final pokemon = viewModel.filteredPokemons[index];

              return ListTile(
                title: Text(pokemon.name),
                onTap: () {
                  viewModel.setSelectedIndex(index);
                },
              );
            },
          )),
        ],
      ),
    );
  }

  TextField SearchBarWidget() {
    final viewModel = context.read<PokedexProvider>().viewModel as CatchSelectorViewModel;
    
    return TextField(
      controller: controller,
      onChanged: (text) {
        viewModel.filterPokemons(controller.text);
      },
      decoration: InputDecoration(
          hintText: 'Nombre de Pokemon',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search)),
    );
  }
}
