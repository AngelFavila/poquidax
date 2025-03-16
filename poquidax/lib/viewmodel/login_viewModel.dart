import 'package:flutter/material.dart';

class LoginViewModel {
  String _username = '';
  String _password = '';
  final ValueNotifier<String> _usernameNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');

  // Remove final so it can be set
  late Function onLoginResult;  // This allows it to be mutable

  // Constructor with the callback parameter
  LoginViewModel({required this.onLoginResult});

  // Getter for the username notifier
  ValueNotifier<String> get usernameNotifier => _usernameNotifier;

  // Getter for the password notifier
  ValueNotifier<String> get passwordNotifier => _passwordNotifier;

  // Setters for username and password
  set username(String value) {
    _username = value.trim();
    _usernameNotifier.value = _username;
  }

  set password(String value) {
    _password = value.trim();
    _passwordNotifier.value = _password;
  }

  // Handle login logic
  void handleLogin() {
    onLoginResult(_isValidCredentials());
  }

  // Example validation for username and password
  bool _isValidCredentials() {
    return _username == 'admin' && _password == '12345';
  }
}
