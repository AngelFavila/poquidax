import 'package:flutter/material.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/view/widgets/pokemon/pokemon_widget.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';

class PokemonViewModel extends ChangeNotifier
    with ViewModelNavigator
    implements PokedexVmInterface {
  @override
  String secondaryScreenText = 'Cargando pokemon...';

  @override
  Widget get screenContent => PokemonWidget();

  Pokemon? _pokemon;
  bool _isLoading = false;

  Pokemon? get pokemon => _pokemon;
  bool get isLoading => _isLoading;

  late int _selectedPokemonNumber;
  int get selectedPokemonNumber => _selectedPokemonNumber;

  @override
  void onBackButton() {
    changeModelAndPop(HomeViewModel());
  }

  @override
  void onAcceptButton() {}

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

  Future<void> setSelectePokemonNumber(int index) async {
    _isLoading = true;
    notifyListeners();

    _selectedPokemonNumber = index;

    try {
      _pokemon = await ApiService().getPokemonByNumber(index);
      secondaryScreenText = 'Especie:'+_pokemon!.name+'\nTipo:'+_pokemon!.type;
    } catch (e) {
      print("Failed to fetch pokemon: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

}
