import 'package:flutter/material.dart';
import 'package:pokedax/model/custom_pokemon.dart';
import 'package:pokedax/model/pokemon.dart';
import 'package:pokedax/services/api_service.dart';
import 'package:pokedax/services/preferences_service.dart';
import 'package:pokedax/view/widgets/home/main_menu_widget.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/base/pokedex_vm_interface.dart';

class HomeViewModel extends ChangeNotifier with ViewModelNavigator implements PokedexVmInterface {
  void Function(int)? onSelectedIndexChanged;
  Widget _screenContent = MainMenuWidget();
  Widget get screenContent => _screenContent;
  @override
  Widget secondaryScreenContent = Text('Selecciona una opción del menú');

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  
  @override
  void onBackButton() {
    if (!_isDialogVisible) {
    _isDialogVisible = true;
    notifyListeners();
  }
  }

  @override
  void onAcceptButton() {
    print("Accept Button pressed");
    if (selectedIndex == 0) {
      navigateTo('/selector');
    } else if (selectedIndex == 1) {
      navigateTo('/catch_selector');
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
  Future<void> onDPadRight() async {
    print("DPad Right pressed");
    await ApiService().removePokemon(CustomPokemon(user: PreferencesService().uuid, id: 3, number: 8, name: 'Vulvasaurio cambiado', level: 5, hp: 20));
  }

  // Metodos adicionales
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    print('HomeViewModel: setSelectedIndex to $_selectedIndex → notifying listeners');
    if (onSelectedIndexChanged != null) {
      onSelectedIndexChanged!(index);
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    await PreferencesService().clearUserData();
    navigateTo('/login');
  }
  
  @override
  set secondaryScreenWidget(Widget value) {
    // TODO: implement secondaryScreenWidget
  }
  
  String _dialogText = 'Cerrar sesión?';

  @override
  String get dialogText => _dialogText;
  
  bool _isDialogVisible = false;
  @override

  bool get isDialogVisible => _isDialogVisible;
  
  @override
  void noPressed() {}
  
  @override
  void yesPressed() {
    logOut();
  }
  
  @override
  void showDialog() {
    _isDialogVisible = false;
  }


}
