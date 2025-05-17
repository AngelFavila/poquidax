import 'package:flutter/material.dart';
import 'package:pokedax/model/custom_pokemon.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/view/helpers/string_helper.dart';
import 'package:pokedax/view/widgets/pokemon/pokemon_widget.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';

class PokemonViewModel extends ChangeNotifier
    with ViewModelNavigator, StringHelper
    implements PokedexVmInterface {
  @override
  Widget secondaryScreenContent = Text('');

  @override
  Widget get screenContent => PokemonWidget();

  Pokemon? _pokemon;
  CustomPokemon? _customPokemon;
  CustomPokemon? get customPokemon => _customPokemon;
  set customPokemon(CustomPokemon? value) {
    _customPokemon = value;
    notifyListeners();
  }

  bool _isLoading = false;

  Pokemon? get pokemon => _pokemon;
  bool get isLoading => _isLoading;

  late String _userUid;
  String get user => _userUid;
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

  Future<void> setSelectePokemonNumber(int index, String user) async {
    _isLoading = true;
    notifyListeners();

    _selectedPokemonNumber = index;
    _userUid = user;

    try {
      _customPokemon = await ApiService().fetchByIdAndUser(index, user);
      _pokemon = await ApiService().getPokemonByNumber(_customPokemon!.number);

      secondaryScreenContent = SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${_customPokemon!.name}'),
              Text('Especie: ${formatAsTitle(pokemon!.name)}'),
              Text('Nivel: ${_customPokemon!.level}'),
              Text('HP: ${_customPokemon!.hp}'),
              Text('Tipo: ${formatAsTitle(_pokemon!.type)}'),
            ],
          ),
        ),
      );
    } catch (e) {
      print("Failed to fetch pokemon: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  set secondaryScreenWidget(Widget value) {
    // TODO: implement secondaryScreenWidget
  }
}
