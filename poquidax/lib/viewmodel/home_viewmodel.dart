import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/services/preferences_service.dart';
import 'package:pokedax/viewmodel/pokedex_vm_interface.dart';

class HomeViewModel extends ChangeNotifier implements PokedexVmInterface {
  final Ref ref;
  void Function(int)? onSelectedIndexChanged;
  
  HomeViewModel(this.ref);

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
    }
  }

  @override
  void onDPadDown() {
    if (selectedIndex + 1 <= 2) {
      setSelectedIndex(selectedIndex + 1);
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
    notifyListeners();
    if (onSelectedIndexChanged != null) {
      onSelectedIndexChanged!(index);
    }
  }

  int get selectedIndex => _selectedIndex;

  Future<void> logOut() async {
    NavigationService.go('/login');
    await PreferencesService().clearUserData();
  }
}
