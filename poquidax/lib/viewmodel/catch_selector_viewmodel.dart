import 'package:flutter/material.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/view/widgets/catch_selector/catch_widget.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';

class CatchSelectorViewModel extends ChangeNotifier with ViewModelNavigator implements PokedexVmInterface {
  @override
  String secondaryScreenText = 'Selecciona un pokemon para atrapar';
  
  @override
  Widget get screenContent => CatchWidget();
  
  List<Pokemon> _pokemons = [];
  get pokemons => _pokemons;
  List<Pokemon> _filteredPokemons = [];
  get filteredPokemons => _filteredPokemons;
  var selectedIndex;

  CatchSelectorViewModel() {
    _init();
  }

  Future<void> _init() async {
    await getPokemons();
    _filteredPokemons = _pokemons;
  }

  // Metodos de la interfaz
  @override
  void onBackButton() {
    // Regresa al menú principal con un pop
    changeModelAndPop(HomeViewModel());
    notifyListeners();
  }

  @override
  void onAcceptButton() {
    navigateTo('/catch');
  }

  @override
  void onDPadUp(){}

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

  // Metodos adicionales
  Future<List<Pokemon>> getPokemons() async {
    if (_pokemons.isEmpty) {
      _pokemons = await ApiService().getAllPokemons();
    }
    notifyListeners();

    return _pokemons;
  }

  // Manda a la pantalla de atrapar pokemon
  // y le pasa el numero del pokemon seleccionado
  void selectPokemon(int index) {
    final number = _filteredPokemons[index].number;
    navigateTo('/catch?number=$number');
  }

  // Filtra los pokemones por nombre si el query no está vacío
  // y devuelve una lista de pokemones filtrados o la lista completa
  List<Pokemon> filterPokemons(String query) {
    notifyListeners();

    return query.isEmpty ? _pokemons : _isNotEmptyFilterPokemons(query);
  }

  // Filtra los pokemones por nombre
  // y devuelve una lista de pokemones filtrados
  List<Pokemon> _isNotEmptyFilterPokemons(String query) {
    return _pokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

}
