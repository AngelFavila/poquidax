import 'package:flutter/material.dart';
import 'package:pokedax/model/custom_pokemon.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';

class CatchFormViewmodel extends ChangeNotifier
    with ViewModelNavigator
    implements PokedexVmInterface {
  @override
  String secondaryScreenText = 'Atrapa un pokemon';

  Pokemon? pokemon;
  CustomPokemon? customPokemon;

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void onAcceptButton() {
    // TODO: implement onAcceptButton
  }

  @override
  void onBackButton() {
    // TODO: implement onBackButton
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
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  // TODO: implement screenContent
  Widget get screenContent => throw UnimplementedError();
}
