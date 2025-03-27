import 'package:flutter/material.dart';
import 'package:pokedax/view/session/widgets/custom_text_field.dart';
import '../../viewmodel/login_viewmodel.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  final LoginViewModel _viewModel;
  final Size screenSize;

  LoginView(this._viewModel, {super.key, required this.screenSize, required Function onLoginResult,}) {
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
          _emailField(),
          SizedBox(height: 10),
          _passwordField(),
          SizedBox(height: 10),
          LoginButton(),
          SizedBox(height: 10),
          SignUpButton(),
        ],
      ),
    );
  }

  // Email Field creado desde factory
  Widget _emailField() {
    return CustomTextField(
      label: "Email",
      size: MediaQuery.of(context).size,
      notifier: widget._viewModel.emailNotifier,
      hints: [AutofillHints.email],
      onChanged: (value) {
        widget._viewModel.email = value; // Update email in ViewModel
      },
    );
  }

  // Password field creado desde factory
  Widget _passwordField() {
    return CustomTextField(
      obscureText: true,
      label: "Contraseña",
      size: MediaQuery.of(context).size,
      notifier: widget._viewModel.passwordNotifier,
      hints: [AutofillHints.password],
      onChanged: (value) {
        widget._viewModel.password = value; // Update password in ViewModel
      },
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
