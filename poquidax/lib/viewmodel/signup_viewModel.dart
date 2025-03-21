import 'package:flutter/material.dart';
import 'package:pokedax/services/auth_service.dart';

class SignUpViewModel {
  String _email = '';
  String _password = '';
  final ValueNotifier<String> _usernameNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');

  late Function
  onLoginResult; // Callback para notificar si el login es exitoso o no
  SignUpViewModel({required this.onLoginResult});

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

  void handleSignUp() {
    AuthService().signUp(email: _email,password: _password);
  }
}
