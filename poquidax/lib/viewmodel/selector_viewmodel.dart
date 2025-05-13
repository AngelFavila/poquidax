import 'package:flutter/material.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';

class SelectorViewModel extends ChangeNotifier implements PokedexVmInterface{

  @override
  String secondaryScreenText = 'Selecciona uno de tus pokemones';
  
  @override
  Widget get screenContent => Placeholder();

  @override
  void onBackButton() {
    NavigationService.go('/');
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

  
}
