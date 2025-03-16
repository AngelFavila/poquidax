import 'package:flutter/material.dart';
import '../../viewmodel/login_viewModel.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  LoginViewModel _viewModel;
  final Size screenSize;

  LoginView(this._viewModel, {super.key, required this.screenSize, required Function onLoginResult}) {
    _viewModel.onLoginResult = onLoginResult; 
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserField(),
        PasswordField(),
        LoginButton(),
      ],
    );
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
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
        widget._viewModel.handleLogin(); // Funcion de Login
      },
      child: Text("Login"),
    );
  }
}
