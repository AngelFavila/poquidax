import 'package:flutter/material.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/view/widgets/catch_selector/catch_widget.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';

class CatchSelectorViewModel extends ChangeNotifier
    with ViewModelNavigator
    implements PokedexVmInterface {
  @override
  Widget get screenContent => CatchWidget();

  @override
  Widget secondaryScreenContent = Text('Selecciona un pokemon para atrapar');

  List<Pokemon> _pokemons = [];
  get pokemons => _pokemons;
  List<Pokemon> _filteredPokemons = [];
  get filteredPokemons => _filteredPokemons;
  var selectedIndex;
  var focusedIndex = 0;

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
  }

  @override
  void onAcceptButton() {
    if (focusedIndex == -1) return;
    if (_filteredPokemons.isEmpty) return;
    final number = _filteredPokemons[focusedIndex].number;
    navigateTo('/catch?number=$number');
  }

  @override
  void onDPadUp() {
    if (_filteredPokemons.isEmpty) return;
    focusedIndex = (focusedIndex - 1 + _filteredPokemons.length) %
        _filteredPokemons.length;
    notifyListeners();
  }

  @override
  void onDPadDown() {
    if (_filteredPokemons.isEmpty) return;
    focusedIndex = (focusedIndex + 1) % _filteredPokemons.length;
    notifyListeners();
  }

  @override
  void onDPadLeft() {
    if (_filteredPokemons.isEmpty) return;
    focusedIndex = (focusedIndex - 1 + _filteredPokemons.length) %
        _filteredPokemons.length;
    notifyListeners();
  }

  @override
  void onDPadRight() {
    if (_filteredPokemons.isEmpty) return;
    focusedIndex = (focusedIndex + 1) % _filteredPokemons.length;
    notifyListeners();
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
    focusedIndex = 0;
    _filteredPokemons =
        query.isEmpty ? _pokemons : _isNotEmptyFilterPokemons(query);
    notifyListeners();

    return _filteredPokemons;
  }

  // Filtra los pokemones por nombre
  // y devuelve una lista de pokemones filtrados
  List<Pokemon> _isNotEmptyFilterPokemons(String query) {
    return _pokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  set secondaryScreenWidget(Widget value) {
    // TODO: implement secondaryScreenWidget
  }

  @override
  // TODO: implement dialogText
  String get dialogText => throw UnimplementedError();

  bool _isDialogVisible = false;

  @override
  // TODO: implement isDialogVisible
  bool get isDialogVisible => _isDialogVisible;

  @override
  void noPressed() {
    // TODO: implement noPressed
  }

  @override
  void yesPressed() {
    // TODO: implement yesPressed
  }

  @override
  void showDialog() {
    // TODO: implement showDialog
  }
}
