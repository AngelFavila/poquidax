import 'package:flutter/material.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';

class CatchWidget extends StatefulWidget {
  final Size screenSize;
  final CatchSelectorViewModel viewModel; // Add the ViewModel as a parameter

  CatchWidget({required this.screenSize, required this.viewModel});

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
    return Container(
      width: widget.screenSize.width,
      height: widget.screenSize.height,
      color: Colors.white,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: SearchBarWidget()),
          Expanded(
              child: ListView.builder(
            itemCount: widget.viewModel.filteredPokemons.length,
            itemBuilder: (context, index) {
              final pokemon = widget.viewModel.filteredPokemons[index];

              return ListTile(
                title: Text(pokemon.name),
                onTap: () {
                  widget.viewModel.setSelectedIndex(index);
                },
              );
            },
          )),
        ],
      ),
    );
  }

  TextField SearchBarWidget() {
    return TextField(
      controller: controller,
      onChanged: (text) {
        widget.viewModel.filterPokemons(controller.text);
      },
      decoration: InputDecoration(
          hintText: 'Nombre de Pokemon',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search)),
    );
  }
}
