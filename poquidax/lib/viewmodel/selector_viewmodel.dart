import 'package:flutter/material.dart';
import 'package:pokedax/model/custom_pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/services/preferences_service.dart';
import 'package:pokedax/view/widgets/selector/selector_widget.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';

class SelectorViewModel extends ChangeNotifier with ViewModelNavigator implements PokedexVmInterface{

   @override
  Widget secondaryScreenContent = Text('Selecciona un pokemon para atrapar');
  
  @override
  Widget get screenContent => SelectorWidget();
  
  List<CustomPokemon> _customPokemons = [];
  get pokemons => _customPokemons;
  List<CustomPokemon> _filteredCustomPokemons = [];
  get filteredPokemons => _filteredCustomPokemons;
  var selectedIndex;
  var focusedIndex = 0;

  SelectorViewModel() {
    _init();
  }

  Future<void> _init() async {
    await getPokemons();
    _filteredCustomPokemons = _customPokemons;
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
    if (_filteredCustomPokemons.isEmpty) return;
    selectPokemon(focusedIndex);
  }

  @override
  void onDPadUp(){
    if(focusedIndex > 0) {
      focusedIndex--;
      notifyListeners();
    }
  }

  @override
  void onDPadDown() {
    if(focusedIndex < _filteredCustomPokemons.length - 1) {
      focusedIndex++;
      notifyListeners();
    }
  }

  @override
  void onDPadLeft() {
    if(focusedIndex > 0) {
      focusedIndex--;
      notifyListeners();
    }
  }

  @override
  void onDPadRight() {
    if(focusedIndex < _filteredCustomPokemons.length - 1) {
      focusedIndex++;
      notifyListeners();
    }
  }

  // Metodos adicionales
  Future<List<CustomPokemon>> getPokemons() async {
    String uid = await PreferencesService().uuid;
    if (_customPokemons.isEmpty) {
      _customPokemons = await ApiService().getPokemonsByUID(uid);
    }
    notifyListeners();

    return _customPokemons;
  }

  // Manda a la pantalla de atrapar pokemon
  // y le pasa el numero del pokemon seleccionado
  void selectPokemon(int index) {
    final number = _filteredCustomPokemons[index].id;
    navigateTo('/pokemon?number=$number&uid=${_filteredCustomPokemons[index].user}');
  }

  // Filtra los pokemones por nombre si el query no está vacío
  // y devuelve una lista de pokemones filtrados o la lista completa
  List<CustomPokemon> filterPokemons(String query) {
    focusedIndex = 0;
    _filteredCustomPokemons = query.isEmpty ? _customPokemons : _isNotEmptyFilterPokemons(query);
    notifyListeners();
    
    return _filteredCustomPokemons;
  }

  // Filtra los pokemones por nombre
  // y devuelve una lista de pokemones filtrados
  List<CustomPokemon> _isNotEmptyFilterPokemons(String query) {
    return _customPokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
  
  @override
  set secondaryScreenWidget(Widget value) {
    // TODO: implement secondaryScreenWidget
  }

  
}
