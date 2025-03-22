import 'package:flutter/material.dart';
import '../../viewmodel/login_viewModel.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  final LoginViewModel _viewModel;
  final Size screenSize;

  LoginView(
    this._viewModel, {
    super.key,
    required this.screenSize,
    required Function onLoginResult,
  }) {
    _viewModel.onLoginResult = onLoginResult;
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter, // Centers the content inside
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Prevents Column from taking full height
        children: [
          SizedBox(
            height: 40,
          ),
          UserField(),
          SizedBox(height: 10),
          PasswordField(),
          SizedBox(height: 10),
          LoginButton(),
          SizedBox(height: 10),
          SignUpButton(),
        ],
      ),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
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
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          );
        },
      ),
    );
  }

  // Login Button
  Widget LoginButton() {
    return SizedBox(
      width: double.infinity, 
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.screenSize.width * 0.1),
        child: ElevatedButton(
          onPressed: () {
            widget._viewModel.handleLogin();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow, 
            foregroundColor: Colors.black, 
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), 
            ), 
          ),
          child: Text("Login"),
        ),
      ),
    );
  }

  // SignUp Button
  Widget SignUpButton() {
    return SizedBox(
      width: double.infinity, 
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.screenSize.width * 0.1),
        child: ElevatedButton(
          onPressed: () {
            widget._viewModel.onSignUpClick();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow, 
            foregroundColor: Colors.black, 
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), 
            ), 
          ),
          child: Text("Sign Up"),
        ),
      ),
    );
  }
}
