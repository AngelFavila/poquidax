import 'package:flutter/material.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class HomeViewModel extends ChangeNotifier implements PokedexVmInterface {
  HomeViewModel();

  @override
  void onBackButton() {
    NavigationService.go('/login');
  }

  @override
  void onAcceptButton() {
    print("Accept Button pressed");
    if (selectedIndex == 0) {
      NavigationService.go('/selector');
    } else if (selectedIndex == 1) {
      NavigationService.go('/catch');
    } else if (selectedIndex == 2) {
      NavigationService.go('/login');
    }
  }

  @override
  void onDPadUp() {
    if (selectedIndex - 1 >= 0) {
      setSelectedIndex(selectedIndex - 1);
    }
  }

  @override
  void onDPadDown() {
    if (selectedIndex + 1 <= 2) {
      setSelectedIndex(selectedIndex + 1);
    }
  }

  @override
  void onDPadLeft() {
    print("DPad Left pressed");
  }

  @override
  void onDPadRight() {
    print("DPad Right pressed");
  }

  int _selectedIndex = 0;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}
