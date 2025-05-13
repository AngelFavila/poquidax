import 'package:flutter/material.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/view/widgets/catch/catch_form_view.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';

class PokemonViewModel extends ChangeNotifier
    with ViewModelNavigator
    implements PokedexVmInterface {
  @override
  String secondaryScreenText = 'Stats de tu pokemon';

  @override
  Widget get screenContent => CatchFormView();

  late Pokemon _pokemon;
  Pokemon get pokemon => _pokemon;
  late int _selectedPokemonNumber;
  int get selectedPokemonNumber => _selectedPokemonNumber;

  @override
  void onBackButton() {
    changeModelAndPop(CatchSelectorViewModel());
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

  void setSelectePokemonNumber(int index) {
    _selectedPokemonNumber = index;
  }

}
