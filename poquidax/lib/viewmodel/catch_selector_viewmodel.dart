import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class CatchSelectorViewModel extends ChangeNotifier
    implements PokedexVmInterface {
  var selectedIndex;
  final Ref ref;
  CatchSelectorViewModel(this.ref) {
    _init();
  }

  Future<void> _init() async {
    await getPokemons();
    _filteredPokemons = _pokemons;
  }

  @override
  void onBackButton() {
    NavigationService.pop();
  }

  @override
  void onAcceptButton() {
    NavigationService.push('/catch');
  }

  @override
  void onDPadUp() {}

  @override
  void onDPadDown() {}

  @override
  void onDPadLeft() {
    print("DPad Left pressed");
  }

  @override
  void onDPadRight() {
    print("DPad Right pressed");
  }

  List<Pokemon> _pokemons = [];
  get pokemons => _pokemons;
  List<Pokemon> _filteredPokemons = [];
  get filteredPokemons => _filteredPokemons;
  int _selectedPokemonIndex = 0;

  Future<List<Pokemon>> getPokemons() async {
    if (_pokemons.isEmpty) {
      _pokemons = await ApiService().getAllPokemons();
    }
    notifyListeners();

    return _pokemons;
  }

  void setSelectedIndex(int index) {
    _selectedPokemonIndex = index;
    final number = _filteredPokemons[index].number-1;
    NavigationService.push('/catch?number=$number');
    notifyListeners();
  }

  List<Pokemon> filterPokemons(String query) {
    if (query.isEmpty) {
      _filteredPokemons = _pokemons;
    } else {
      _filteredPokemons = _pokemons.where((pokemon) {
        return pokemon.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();

    return _filteredPokemons;
  }

  @override
  String secondaryScreenText = 'Selecciona un pokemon para atrapar';

}
