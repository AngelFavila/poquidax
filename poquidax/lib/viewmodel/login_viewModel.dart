import 'package:flutter/material.dart';
import 'package:pokedax/services/auth_service.dart';

class LoginViewModel {
  String _email = '';
  String _password = '';
  final ValueNotifier<String> _usernameNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');

  late Function
  onLoginResult; // Callback para notificar si el login es exitoso o no
  LoginViewModel({required this.onLoginResult, required this.onSignUpClick});

  late Function
  onSignUpClick; // Callback para boton de Sign up

  ValueNotifier<String> get usernameNotifier => _usernameNotifier;
  ValueNotifier<String> get passwordNotifier => _passwordNotifier;

  set username(String value) {
    _email = value.trim();
    _usernameNotifier.value = _email;
  }

  set password(String value) {
    _password = value.trim();
    _passwordNotifier.value = _password;
  }

  Future<void> handleLogin() async {
      onLoginResult(await AuthService().signIn(email: _email,password: _password));
  }

  Future<void> goToSignUp() async{
    onSignUpClick();
  }
}
