import 'package:flutter/material.dart';
import 'package:pokedax/view/session/painter/arrow_painter.dart';
import 'package:pokedax/view/session/widgets/custom_text_field.dart';
import '../../viewmodel/login_viewmodel.dart';

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
    return Stack(
      
      children: [
        // Custom painter with the yellow arrow
        Positioned.fill(
          child: CustomPaint(
            painter: ArrowPainter(),
          ),
        ),
        // The rest of the content
        Container(
          
          alignment: Alignment.topCenter, // Centers the content inside
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Prevents Column from taking full height
            children: [
              SizedBox(height: 40),
              _emailField(),
              SizedBox(height: 10),
              _passwordField(),
              SizedBox(height: 10),
              _loginButton(),
              SizedBox(height: 10),
              _signUpButton(),
            ],
          ),
        ),
      ],
    );
  }

  // Email Field creado desde factory
  Widget _emailField() {
    Size customSize = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.04);

    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.2,
          right: MediaQuery.of(context).size.width * 0.2),
      child: CustomTextField(
        label: "Email",
        size: customSize,
        notifier: widget._viewModel.emailNotifier,
        hints: [AutofillHints.email],
        onChanged: (value) {
          widget._viewModel.email = value; // Actualiza el email en el viewmodel
        },
      ),
    );
  }

  // Password field creado desde factory
  Widget _passwordField() {
    Size customSize = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.04);

    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.2,
          right: MediaQuery.of(context).size.width * 0.2),
      child: CustomTextField(
        obscureText: true,
        label: "Contraseña",
        size: customSize,
        notifier: widget._viewModel.passwordNotifier,
        hints: [AutofillHints.password],
        onChanged: (value) {
          widget._viewModel.password = value; // Actualiza el password en el viewmodel
        },
      ),
    );
  }

  // Login Button
  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      height:
          widget.screenSize.height * 0.04,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.screenSize.width * 0.2),
        child: ElevatedButton(
          onPressed: () {
            widget._viewModel.handleLogin();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            padding:EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(widget.screenSize.width * 0.02),
            ),
          ),
          child: const Text("Ingresar"),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      width: double.infinity,
      height:
          widget.screenSize.height * 0.04, 
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.screenSize.width * 0.2),
        child: ElevatedButton(
          onPressed: () {
            widget._viewModel.onSignUpClick();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            padding: EdgeInsets.zero, 
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(widget.screenSize.width * 0.02),
            ),
          ),
          child: const Text("Crear Cuenta"),
        ),
      ),
    );
  }
}

