import 'package:flutter/material.dart';
import 'package:pokedax/services/firebase/auth_service.dart';

class LoginViewModel {
  // Variables privadas de email y contraseña
  String _email = '';
  String _password = '';

  // Notificadores del cambio de los valores de usuario y contraseña
  final ValueNotifier<String> _emailNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');

  // Variables que notifican 
  ValueNotifier<String> get emailNotifier => _emailNotifier;
  ValueNotifier<String> get passwordNotifier => _passwordNotifier;

  // Método callback que va a llamar al método en el mainViewModel al dar un resultado de login
  late Function onLoginResult; 
  // Método callback que va a llamar al método en el mainViewModel al dar click en Ir a Sign Up
  late Function onSignUpClick; 

  // Constructor que recibe métodos
  LoginViewModel({required this.onLoginResult, required this.onSignUpClick});

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
      onLoginResult(await AuthService().verify_credentials(email: _email, password: _password));
  }

  // Dispara el método para navegar a la ventana de Sign Up que se encuentra en el MainViewModel
  Future<void> goToSignUp() async{
    onSignUpClick();
  }
}
