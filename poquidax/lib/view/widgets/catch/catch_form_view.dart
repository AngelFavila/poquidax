import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/viewmodel/catch_form_viewmodel.dart';
import 'package:provider/provider.dart';

class CatchFormView extends StatefulWidget {
  @override
  _CatchFormViewState createState() => _CatchFormViewState();
}

class _CatchFormViewState extends State<CatchFormView> {
  late TextEditingController _nameController;
  late TextEditingController _levelController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _levelController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final viewModel = context.read<PokedexProvider>().viewModel as CatchFormViewModel;
      if (viewModel.customPokemon != null) {
        _nameController.text = viewModel.customPokemon!.name;
        _levelController.text = viewModel.customPokemon!.level.toString();
        _initialized = true;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PokedexProvider>().viewModel as CatchFormViewModel;

    if (viewModel.pokemon == null || viewModel.customPokemon == null) {
      return Container(color: Colors.black);
    }

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.black, width: 1),
      children: [
        _buildRow('Nombre', 
          controller: _nameController,
          onChanged: (value) => viewModel.setCustomPokemonName(value),
          isBold: true
        ),
        _buildRow('Especie', value: viewModel.pokemon!.name),
        _buildRow('Nivel', 
          controller: _levelController,
          onChanged: (value) {
            final parsed = int.tryParse(value);
            if (parsed != null) {
              viewModel.setCustomPokemonLevel(parsed);
            }
          }
        ),
        _buildRow('HP', value: viewModel.customPokemon!.hp.toString(), isBold: true),
        _buildRow('Tipo', value: viewModel.pokemon!.type),
      ],
    );
  }

  TableRow _buildRow(String title,
      {String? value, bool isBold = false, TextEditingController? controller, Function(String)? onChanged}) {
    final isEditable = controller != null;
    
    return TableRow(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: isEditable
              ? TextField(
                  controller: controller,
                  onChanged: onChanged,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                      title == 'Nivel' ? TextInputType.number : TextInputType.text,
                )
              : Text(value ?? '', style: const TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
