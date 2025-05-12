import 'package:flutter/material.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class CatchSelectorViewModel extends ChangeNotifier
  implements PokedexVmInterface {
  var selectedIndex;

  CatchSelectorViewModel() {
    _init();
  }

  Future<void> _init() async {
    await getPokemons();
    _filteredPokemons = _pokemons;
  }

  @override
  void onBackButton() {
    NavigationService.pop();
    notifyListeners();
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

  Future<List<Pokemon>> getPokemons() async {
    if (_pokemons.isEmpty) {
      _pokemons = await ApiService().getAllPokemons();
    }
    notifyListeners();

    return _pokemons;
  }

  void setSelectedIndex(int index) {
    final number = _filteredPokemons[index].number - 1;
    NavigationService.push('/catch?number=$number');
  }

  List<Pokemon> filterPokemons(String query) {
    notifyListeners();

    return query.isEmpty ? _pokemons : isNotEmptyFilterPokemons(query);
  }

  List<Pokemon> isNotEmptyFilterPokemons(String query) {
    return _pokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  String secondaryScreenText = 'Selecciona un pokemon para atrapar';
  
  @override
  // TODO: implement screenContent
  Widget get screenContent => throw UnimplementedError();
}
