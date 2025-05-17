import 'package:flutter/material.dart';
import 'package:pokedax/model/custom_pokemon.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/services/preferences_service.dart';
import 'package:pokedax/view/widgets/catch/catch_form_view.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';

class CatchFormViewModel extends ChangeNotifier
    with ViewModelNavigator
    implements PokedexVmInterface {
  @override
  String secondaryScreenText = 'Atrapa un pokemon';

  Pokemon? _pokemon;
  Pokemon? get pokemon => _pokemon;
  CustomPokemon? _customPokemon;
  CustomPokemon? get customPokemon => _customPokemon;
  int selectedPokemon = 0;
  int customPokemonId = 0;
  String _userUid = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  CatchFormViewModel() {
    _init();
  }

  Future<void> _init() async {
    _userUid = await PreferencesService().uuid;
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onAcceptButton() {
    // TODO: implement onAcceptButton
  }

  @override
  void onBackButton() {
    navigateTo('/catch_selector');	
  }

  @override
  void onDPadDown() {
    // TODO: implement onDPadDown
  }

  @override
  void onDPadLeft() {
    // TODO: implement onDPadLeft
  }

  @override
  void onDPadRight() {
    // TODO: implement onDPadRight
  }

  @override
  void onDPadUp() {
    // TODO: implement onDPadUp
  }

  @override
  // TODO: implement screenContent
  Widget get screenContent => CatchFormView();

  Future<void> setSelectePokemonNumber(int number) async {
    _isLoading = true;
    notifyListeners();

    try {
      _pokemon = await ApiService().getPokemonByNumber(number);
      _customPokemon = CustomPokemon(user: _userUid, id:-1, number: number, name:'', level: 1, hp: _pokemon!.hp);
      notifyListeners();
    } catch (e) {
      print("Failed to fetch pokemon: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void setCustomPokemonId(int id) {
    customPokemonId = id;
    notifyListeners();
  }

  void setCustomPokemonName(String name) {
    if (_customPokemon != null) {
      _customPokemon!.name = name;
    }
    print(_customPokemon!.name);
    notifyListeners();
  } 
  void setCustomPokemonLevel(int level) {
    if (_customPokemon != null) {
      _customPokemon!.level = level;
    }
    print(_customPokemon!.level);
    notifyListeners();
  }
}
