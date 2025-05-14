import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/services/firebase/auth_service.dart';
import 'package:pokedax/services/navigation_service.dart';
import 'package:pokedax/services/preferences_service.dart';
import 'package:pokedax/viewmodel/base/viewmodel_navigator.dart';
import 'package:pokedax/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier with ViewModelNavigator{
  // Variables privadas de email y contraseña
  String _email = '';
  String _password = '';

  // Notificadores del cambio de los valores de usuario y contraseña
  final ValueNotifier<String> _emailNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');

  // Variables que notifican
  ValueNotifier<String> get emailNotifier => _emailNotifier;
  ValueNotifier<String> get passwordNotifier => _passwordNotifier;

  // Constructor que recibe métodos
  LoginViewModel();

  // Set público del email para poder cambiar el valor desde el view
  set email(String value) {
    _email = value.trim();
    _emailNotifier.value = _email;
  }

  // Set público del password para poder cambiar el valor desde el view
  set password(String value) {
    _password = value.trim();
    _passwordNotifier.value = _password;
  }

  // Dispara al método callback en el MainViewModel y le regresa un booleano con la prueba de las credenciales
  Future<void> handleLogin() async {
    String? uid = await AuthService().verify_credentials(email: _email, password: _password);
    if (uid != null) {
      final provider = Provider.of<PokedexProvider>(NavigationService.navigatorKey.currentContext!, listen: false);
      provider.changeModel(HomeViewModel());
      await PreferencesService().setUUID(uid);
      navigateTo("/");
      print("Login successful, uid: $uid");
    }
  }

  // Dispara el método para navegar a la ventana de Sign Up que se encuentra en el MainViewModel
  Future<void> goToSignUp() async {
    NavigationService.push("/signup");
  }
}
