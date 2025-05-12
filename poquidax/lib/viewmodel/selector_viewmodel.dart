import 'package:flutter/material.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class SelectorViewModel extends ChangeNotifier implements PokedexVmInterface{

  SelectorViewModel();

  @override
  void onBackButton() {
    NavigationService.go('/');
  }
  
  @override
  void onAcceptButton() {
    // TODO: implement onAcceptButton
  }
  
  @override
  void onDPadUp() {
    
  }

  @override
  void onDPadDown() {
    
  }
  
  @override
  void onDPadLeft() {
    print("DPad Left pressed");
  }
  
  @override
  void onDPadRight() {
    print("DPad Right pressed");
  }

  @override
  String secondaryScreenText = 'Selecciona uno de tus pokemones';
  
  @override
  // TODO: implement screenContent
  Widget get screenContent => throw UnimplementedError();
  
  
}
