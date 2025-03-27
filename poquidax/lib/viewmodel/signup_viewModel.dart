import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokedax/services/firebase/auth_service.dart';

class SignUpViewModel {
  String _email = '';
  String _password = '';
  final ValueNotifier<String> _emailNotifier = ValueNotifier('');
  final ValueNotifier<String> _passwordNotifier = ValueNotifier('');

  
  ValueNotifier<String> get emailNotifier => _emailNotifier;
  ValueNotifier<String> get passwordNotifier => _passwordNotifier;

  late Function onSignUpResult; // Callback para notificar si el login es exitoso o no
  late Function onBackButton;
  SignUpViewModel({required this.onSignUpResult, required this.onBackButton});


  set email(String value) {
    _email = value.trim();
    _emailNotifier.value = _email;
  }

  set password(String value) {
    _password = value.trim();
    _passwordNotifier.value = _password;
  }

  Future<void> handleSignUp() async {
    if(await AuthService().create_account(email: _email,password: _password))
    {
      Fluttertoast.showToast(msg:"Cuenta creada exitosamente.");
    }
  }

  void backToLogin(){
    onBackButton();
  }
}
