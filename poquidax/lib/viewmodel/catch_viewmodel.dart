import 'package:flutter/material.dart';
import 'package:pokedax/view/catch/widget/catch_form_view.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';

class CatchViewModel extends ChangeNotifier with ViewModelNavigator implements PokedexVmInterface {
  @override
  String secondaryScreenText = 'Personaliza tu Pokemon';
  
  @override
  Widget get screenContent => CatchFormView();
  
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
