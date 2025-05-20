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
  Widget get screenContent => CatchFormView();

  @override
  Widget secondaryScreenWidget = Text('Atrapa un pokemon');

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
  Future<void> onAcceptButton() async {
    _isLoading = true;
    notifyListeners();
    await Future.wait([
      ApiService().savePokemon(_customPokemon!),
      Future.delayed(Duration(milliseconds: 2000)),
    ]);

    navigateTo('/selector');
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

  Future<void> setSelectePokemonNumber(int number) async {
    try {
      _pokemon = await ApiService().getPokemonByNumber(number);
      _customPokemon = CustomPokemon(
          user: _userUid,
          id: -1,
          number: number,
          name: '',
          level: 1,
          hp: _pokemon!.hp);
      notifyListeners();
    } catch (e) {
      print("Failed to fetch pokemon: $e");
    }

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

  @override
  Widget get secondaryScreenContent => Text('Atrapa un pokemon');

  @override
  String get dialogText => throw UnimplementedError();

  bool _isDialogVisible = false;

  @override
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
