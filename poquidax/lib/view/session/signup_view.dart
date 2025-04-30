import 'package:flutter/material.dart';
import 'package:pokedax/providers/scheme_provider.dart';
import 'package:pokedax/view/pokedex/pokedex_banner.dart';
import 'package:pokedax/view/session/painter/arrow_painter.dart';
import 'package:pokedax/view/session/widgets/custom_text_field.dart';
import 'package:pokedax/view/session/widgets/yellow_button.dart';
import 'package:pokedax/viewmodel/signup_viewModel.dart';

class SignUpView extends StatefulWidget {
  final SignUpViewModel _viewModel = new SignUpViewModel();

  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.sizeOf(context);
    
    return Scaffold(
      backgroundColor: myColorScheme.primary,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          children: [
            BannerContainer(
              height: screenSize.height * 0.15,
              colorScheme: myColorScheme,
            ),
            Expanded(
              child: Container(
                width: double.infinity, 
                height:
                    double.infinity, 
                alignment: Alignment.center,
                child: _signUpForm(), 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stack _signUpForm() {
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
          SizedBox(height: 10),
          Title(),
          SizedBox(height: 40),
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
  Text Title() {
    final double fontSize = Theme.of(context).textTheme.bodyLarge!.fontSize!*1.5;

    return Text(
        'Creación de Cuenta',
        style: TextStyle(
          fontSize: fontSize, 
          color: Colors.yellow, 
          shadows: [
            Shadow(
              blurRadius: 3.0,
              color: Colors.black,
              offset: Offset(0.5, 0.5),
            ),
          ],
        ),
      );
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
    return YellowButton(
        text: "Ingresar",
        onPressed: widget._viewModel.handleSignUp,
        screenSize: screenSize);
  }

  // Back to login Button
  Widget _backButton() {
    return YellowButton(
        text: "Volver a Ingreso",
        onPressed: widget._viewModel.backToLogin,
        screenSize: screenSize);
  }
}
