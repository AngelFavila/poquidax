import 'package:flutter/material.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class HomeViewModel extends ChangeNotifier implements PokedexVmInterface{

  HomeViewModel();

  @override
  void onBackButton() {
    NavigationService.go('/login');
  }
  
  @override
  void onAcceptButton() {
    // TODO: implement onAcceptButton
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
}
