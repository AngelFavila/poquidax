import 'package:flutter/material.dart';
import 'package:pokedax/viewmodel/signup_viewModel.dart';

// ignore: must_be_immutable
class SignUpView extends StatefulWidget {
  final SignUpViewModel _viewModel;
  final Size screenSize;

  SignUpView(
    this._viewModel, {
    super.key,
    required this.screenSize,
    required Function onLoginResult,
  }) {
    _viewModel.onLoginResult = onLoginResult;
  }

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [UserField(), PasswordField(), LoginButton()]);
  }

  // User Field
  Widget UserField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.screenSize.width * 0.1),
      child: TextFormField(
        onChanged: (value) {
          widget._viewModel.username = value; // Update ViewModel username
        },
        decoration: InputDecoration(
          labelText: 'Usuario',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
    );
  }

  // Password Field with ValueListenableBuilder
  Widget PasswordField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.screenSize.width * 0.1),
      child: ValueListenableBuilder<String>(
        valueListenable: widget._viewModel.passwordNotifier,
        builder: (context, password, child) {
          return TextFormField(
            onChanged: (value) {
              widget._viewModel.password = value; // Update ViewModel password
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          );
        },
      ),
    );
  }

  // Login Button
  Widget LoginButton() {
    return ElevatedButton(
      onPressed: () {
        widget._viewModel.handleSignUp(); // Funcion de Login
      },
      child: Text("Login"),
    );
  }
}
