import 'package:flutter/material.dart';

class LoginViewModel {
  String _username = '';
  String _password = '';
  final ValueNotifier<String> _usernameNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');

  late Function
  onLoginResult; // Callback para notificar si el login es exitoso o no
  LoginViewModel({required this.onLoginResult});

  ValueNotifier<String> get usernameNotifier => _usernameNotifier;
  ValueNotifier<String> get passwordNotifier => _passwordNotifier;

  set username(String value) {
    _username = value.trim();
    _usernameNotifier.value = _username;
  }

  set password(String value) {
    _password = value.trim();
    _passwordNotifier.value = _password;
  }

  void handleLogin() {
    onLoginResult(
      _isValidCredentials(),
    ); // Callback para notificar si el login es exitoso o no
  }

  bool _isValidCredentials() {
    return _username == 'admin' &&
        _password == '12345'; // Credenciales de ejemplo
  }
}
