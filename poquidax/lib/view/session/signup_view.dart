import 'package:flutter/material.dart';
import 'package:pokedax/view/session/painter/arrow_painter.dart';
import 'package:pokedax/view/session/widgets/custom_text_field.dart';
import 'package:pokedax/viewmodel/signup_viewModel.dart';

// ignore: must_be_immutable
class SignUpView extends StatefulWidget {
  final SignUpViewModel _viewModel;
  final Size screenSize;

  SignUpView(
    this._viewModel, {
    super.key,
    required this.screenSize,
    required Function onSignUpResult,
  }) {
    _viewModel.onSignUpResult = onSignUpResult;
  }

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Custom painter with the yellow arrow
      Positioned.fill(
        child: CustomPaint(
          painter: ArrowPainter(),
        ),
      ),
      Container(
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
            _signUpButton(),
            SizedBox(height: 10),
            _backButton()
          ],
        ),
      )
    ]);
  }
  
  // Email Field creado desde factory
  Widget _emailField() {
    Size customSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.04);

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
          widget._viewModel.email = value; // Update email in ViewModel
        },
      ),
    );
  }

  // Password field creado desde factory
  Widget _passwordField() {
    Size customSize = Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.04);

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
          widget._viewModel.password = value; // Update password in ViewModel
        },
      ),
    );
  }

  // Boton para crear la cuenta
  Widget _signUpButton() {
    return SizedBox(
      width: double.infinity, 
      height: widget.screenSize.height * 0.04, 
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.screenSize.width * 0.2),
        child: ElevatedButton(
          onPressed: () {
            widget._viewModel.handleSignUp();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow, 
            foregroundColor: Colors.black, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.screenSize.width * 0.02), 
            ), 
          ),
          child: Text("Crear Cuenta"),
        ),
      ),
    );
  }

  // Back to login Button
  Widget _backButton() {
    return SizedBox(
      width: double.infinity,
      height: widget.screenSize.height * 0.04, 
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.screenSize.width * 0.2),
        child: ElevatedButton(
          onPressed: () {
            widget._viewModel.onBackButton();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow, 
            foregroundColor: Colors.black, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.screenSize.width * 0.02), 
            ), 
          ),
          child: const Text("Volver al Inicio"),
        ),
      ),
    );
  }
}
