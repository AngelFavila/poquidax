import 'package:flutter/material.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/services/preferences_service.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class HomeViewModel extends ChangeNotifier implements PokedexVmInterface {
  void Function(int)? onSelectedIndexChanged;
  
  HomeViewModel() {
    notifyListeners();
  }

  @override
  void onBackButton() {
    logOut();
  }

  @override
  void onAcceptButton() {
    print("Accept Button pressed");
    if (selectedIndex == 0) {
      NavigationService.push('/selector');
    } else if (selectedIndex == 1) {
      NavigationService.push('/catch_selector');
    } else if (selectedIndex == 2) {
      logOut();
    }
  }

  @override
  void onDPadUp() {
    if (selectedIndex - 1 >= 0) {
      setSelectedIndex(selectedIndex - 1);
      notifyListeners();
    }
  }

  @override
  void onDPadDown() {
    if (selectedIndex + 1 <= 2) {
      setSelectedIndex(selectedIndex + 1);
      notifyListeners();
    }
  }

  @override
  Future<void> onDPadLeft() async {
    print("DPad Left pressed");
    List<Pokemon> listOfPokemons = await ApiService().getAllPokemons();
    print(listOfPokemons.first.name);
  }

  @override
  void onDPadRight() {
    print("DPad Right pressed");
  }

  int _selectedIndex = 0;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    print('HomeViewModel: setSelectedIndex to $_selectedIndex → notifying listeners');
    if (onSelectedIndexChanged != null) {
      onSelectedIndexChanged!(index);
    }
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  Future<void> logOut() async {
    NavigationService.go('/login');
    await PreferencesService().clearUserData();
  }

  @override
  String secondaryScreenText = 'Selecciona una opción del menú';
  
}
