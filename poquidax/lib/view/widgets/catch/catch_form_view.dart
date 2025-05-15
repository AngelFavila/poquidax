import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/viewmodel/catch_form_viewmodel.dart';
import 'package:pokedax/viewmodel/catch_viewmodel.dart';
import 'package:provider/provider.dart';

class CatchFormView extends StatefulWidget {
  CatchFormView();

  @override
  _CatchFormViewState createState() => _CatchFormViewState();
}

class _CatchFormViewState extends State<CatchFormView> {
  var number;

  @override
  void initState() {
    super.initState();
  }

  Widget _mainMenuItem(int index, String title, String subtitle) {
    return Placeholder();
  }

  TableRow _buildRow(String title, String value, {bool isBold = false}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<PokedexProvider>().viewModel as CatchFormViewmodel;
    final pokemon = viewModel.pokemon;
    final customPokemon = viewModel.customPokemon;

    if (pokemon == null || customPokemon == null) {
      return Container(
        color: Colors.black,
        // child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    if (number != null && viewModel is CatchViewModel) {
      if (viewModel.pokemon?.number != number) {
        return Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: Colors.black, width: 1),
          children: [
            _buildRow('Nombre', viewModel.customPokemon!.name, isBold: true),
            _buildRow('Especie', viewModel.pokemon!.name),
            _buildRow('Nivel', viewModel.customPokemon!.level as String),
            _buildRow('HP', viewModel.customPokemon!.hp as String,
                isBold: true),
            _buildRow('Tipo', viewModel.pokemon!.type),
          ],
        );
      }
    }
  }
}
